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
	local task = hs.task.new("/usr/bin/defaults", function(exitCode, stdOut)
		local focusState = (exitCode == 0 and stdOut:match("1")) and true or false

		if lastFocusState ~= focusState then
			lastFocusState = focusState
			print("Focus mode:", focusState and "ON" or "OFF")
			updateSlackStatus(focusState)
		end
	end, { "read", "com.apple.controlcenter", "NSStatusItem VisibleCC FocusModes" })

	task:start()
end

-- Poll for focus mode changes every 10 seconds
hs.timer.doEvery(10, checkFocusMode)

-- Check immediately on load
checkFocusMode()

print("Slack Focus Mode integration loaded")
