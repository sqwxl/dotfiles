local secrets = require("Spoons/secrets")

local MEETING_STATUS = { status_text = "In a meeting", status_emoji = ":headphones:", status_expiration = 0 }
local SAVED_KEY = "zoomSlackSavedStatus"
local ZOOM_BUNDLE_ID = "us.zoom.xos"
-- Zoom runs this helper process only while a meeting is open
local MEETING_PROCESS_BUNDLE_ID = "us.zoom.CptHost"

local headers = {
	["Authorization"] = "Bearer " .. secrets.slack_token,
	["Content-Type"] = "application/json; charset=utf-8",
}

local function setStatus(profile, label, onSuccess)
	local body = hs.json.encode({ profile = profile })
	hs.http.asyncPost("https://slack.com/api/users.profile.set", body, headers, function(status, response)
		local data = status == 200 and hs.json.decode(response)
		if not (data and data.ok) then
			print("✗ Slack status update failed:", status, response)
			return
		end

		print("✓ Slack status:", label)
		onSuccess()
	end)
end

local function onMeetingStart()
	-- A saved status means we're already in a meeting (eg. after a config reload); keep the original
	if hs.settings.get(SAVED_KEY) then
		return
	end

	hs.http.asyncGet("https://slack.com/api/users.profile.get", headers, function(status, response)
		local data = status == 200 and hs.json.decode(response)
		if not (data and data.ok) then
			print("✗ Slack profile fetch failed:", status, response)
			return
		end

		local p = data.profile
		local previous = {
			status_text = p.status_text or "",
			status_emoji = p.status_emoji or "",
			status_expiration = p.status_expiration or 0,
		}
		setStatus(MEETING_STATUS, "In a meeting", function()
			hs.settings.set(SAVED_KEY, previous)
		end)
	end)
end

local function onMeetingEnd()
	local saved = hs.settings.get(SAVED_KEY)
	if not saved then
		return
	end

	if saved.status_expiration ~= 0 and saved.status_expiration < os.time() then
		saved = { status_text = "", status_emoji = "", status_expiration = 0 }
	end
	setStatus(saved, "restored", function()
		hs.settings.clear(SAVED_KEY)
	end)
end

local inMeeting = nil

local function checkMeeting()
	local running = hs.application.get(MEETING_PROCESS_BUNDLE_ID) ~= nil
	if running == inMeeting then
		return
	end

	inMeeting = running
	if running then
		onMeetingStart()
	else
		onMeetingEnd()
	end
end

-- Globals to prevent garbage collection (https://github.com/Hammerspoon/hammerspoon/issues/1942)
-- CptHost is a background-only app, which hs.application.watcher never reports, so re-check on Zoom UI events
zoomMeetingCheck = hs.timer.delayed.new(1, checkMeeting)
zoomAppWatcher = nil

local function watchZoom(app)
	zoomAppWatcher = app:newWatcher(function()
		zoomMeetingCheck:start()
	end):start({ hs.uielement.watcher.windowCreated, hs.uielement.watcher.elementDestroyed })
end

zoomLaunchWatcher = hs.application.watcher
	.new(function(_, event, app)
		if not app or app:bundleID() ~= ZOOM_BUNDLE_ID then
			return
		end

		if event == hs.application.watcher.launched then
			watchZoom(app)
		elseif event == hs.application.watcher.terminated then
			zoomAppWatcher = nil
			zoomMeetingCheck:start()
		end
	end)
	:start()

local zoom = hs.application.get(ZOOM_BUNDLE_ID)
if zoom then
	watchZoom(zoom)
end
checkMeeting()
