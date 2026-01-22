local secrets = require("secrets")

local lastFocusState = nil

function updateSlackStatus(focusState)
	local url = "https://slack.com/api/users.profile.set"
	local headers = {
		["Authorization"] = "Bearer " .. secrets.slack_token,
		["Content-Type"] = "application/json",
	}

	local statusText = focusState and "Focused" or ""
	local statusEmoji = focusState and ":technologist:" or ""

	local body =
		hs.json.encode({ profile = { status_text = statusText, status_emoji = statusEmoji, status_expiration = 0 } })

	hs.http.asyncPost(url, body, headers, function(status, response)
		if status == 200 then
			local data = hs.json.decode(response)
			if data.ok then
				print("✓ Slack status updated:", focusState and "Focus Mode ON" or "Focus Mode OFF")
			else
				print("✗ Slack API error:", data.error)
			end
		else
			print("✗ HTTP error:", status)
		end
	end)

	url = "https://slack.com/api/dnd." .. (focusState and "setSnooze" or "endSnooze")
	body = focusState and hs.json.encode({ num_minutes = 60 }) or nil

	hs.http.asyncPost(url, focusState and body or nil, headers, function(status, response)
		if status == 200 then
			local data = hs.json.decode(response)
			if data.ok then
				print("✓ Slack DND updated:", focusState and "ON" or "OFF")
			else
				print("✗ Slack API error:", data.error)
			end
		else
			print("✗ HTTP error:", status)
		end
	end)
end

function checkFocusMode()
	-- Check DoNotDisturb database (requires Full Disk Access)
	local assertionsPath = os.getenv("HOME") .. "/Library/DoNotDisturb/DB/Assertions.json"
	local file = io.open(assertionsPath, "r")

	if not file then
		print("⚠ Cannot read Focus mode status - Hammerspoon needs Full Disk Access")
		print("   Go to: System Settings → Privacy & Security → Full Disk Access")
		print("   Add: Hammerspoon.app")
		return
	end

	local content = file:read("*all")
	file:close()

	-- Parse JSON and check for active assertions
	local data = hs.json.decode(content)
	local focusState = false

	if data and data.data and #data.data > 0 then
		-- Check if there are any active Focus mode assertions
		for _, assertion in ipairs(data.data) do
			if assertion.storeAssertionRecords and #assertion.storeAssertionRecords > 0 then
				focusState = true
				break
			end
		end
	end

	print("⏰ Focus mode check:", focusState and "ON" or "OFF")

	if lastFocusState ~= focusState then
		lastFocusState = focusState
		print("Focus mode CHANGED:", focusState and "ON" or "OFF")
		updateSlackStatus(focusState)
	end
end

-- Poll for focus mode changes every 10 seconds
-- Wrap in pcall to catch any errors and prevent timer from stopping
-- IMPORTANT: Store as global to prevent garbage collection (see https://github.com/Hammerspoon/hammerspoon/issues/1942)
focusModeTimer = hs.timer.doEvery(10, function()
	local success, err = pcall(checkFocusMode)
	if not success then
		print("⚠ Error in checkFocusMode:", err)
	end
end)

-- Check immediately on load
checkFocusMode()

print("Slack Focus Mode integration loaded")
