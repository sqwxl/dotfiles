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
	-- Use hs.execute for synchronous, simpler execution
	local success, output, error = hs.execute("/usr/bin/defaults read com.apple.controlcenter 'NSStatusItem VisibleCC FocusModes'")

	if not success then
		print("⚠ Failed to check focus mode:", error)
		return
	end

	local focusState = output and output:match("1") and true or false

	if lastFocusState ~= focusState then
		lastFocusState = focusState
		print("Focus mode:", focusState and "ON" or "OFF")
		updateSlackStatus(focusState)
	end
end

-- Poll for focus mode changes every 10 seconds
-- Wrap in pcall to catch any errors and prevent timer from stopping
local pollTimer = hs.timer.doEvery(10, function()
	local success, err = pcall(checkFocusMode)
	if not success then
		print("⚠ Error in checkFocusMode:", err)
	end
end)

-- Check immediately on load
checkFocusMode()

print("Slack Focus Mode integration loaded")
