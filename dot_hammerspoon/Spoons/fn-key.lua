-- Map F13 to the macOS fn / Globe modifier.
--
-- ZMK cannot emit Apple's real fn: it lives on the Apple vendor HID page, which
-- ZMK's report descriptor does not declare (zmkfirmware/zmk#1938). &kp GLOBE
-- sends consumer usage 0x029D instead, which Swish does not recognise. So the
-- keyboard sends F13 and we forge the fn modifier here.
--
-- Swish reads fn from flagsChanged transitions, not from per-event flags:
-- macOS already sets secondaryFn on arrows and F-keys natively, and those do
-- not trigger Swish. So stamping key events is not enough - we post a real
-- flagsChanged on F13 down and up. Stamping is kept for anything that does
-- read per-event flags (fn+delete, etc).
--
-- Event-tap only: no virtual HID driver, so this does not reintroduce the
-- report-reordering that broke the mod-morphs under Karabiner.

local M = {}

local types = hs.eventtap.event.types
local FN_MASK = hs.eventtap.event.rawFlagMasks.secondaryFn
local FN_KEYCODE = hs.keycodes.map.f13

M.debug = true
M.held = false

-- Swish's arrow hotkeys are a fixed enum (arrows/hjkl/ijkl/wasd/dvorak), so
-- arbitrary letters cannot be configured there. Leave Swish on "hjkl" and
-- rewrite the keycodes here instead. h is already left, so it is not listed.
local DIRECTIONS = {
	[hs.keycodes.map.c] = hs.keycodes.map.k, -- up
	[hs.keycodes.map.t] = hs.keycodes.map.j, -- down
	[hs.keycodes.map.n] = hs.keycodes.map.l, -- right
}

-- Rebuild the current modifier state with fn forced on or off, so a real
-- Cmd or Shift held across the F13 press survives the synthetic event.
local function postFnTransition(down)
	local raw = hs.eventtap.checkKeyboardModifiers(true)._raw or 0
	raw = down and (raw | FN_MASK) or (raw & ~FN_MASK)

	hs.eventtap.event.newEvent():setType(types.flagsChanged):rawFlags(raw):post()

	if M.debug then
		print(("fn-key: flagsChanged fn=%s raw=0x%X"):format(tostring(down), raw))
	end
end

local function addFn(e)
	local flags = e:getFlags()
	flags.fn = true
	e:setFlags(flags)
end

M.tap = hs.eventtap.new({ types.keyDown, types.keyUp, types.flagsChanged }, function(e)
	local eventType = e:getType()

	if eventType ~= types.flagsChanged and e:getKeyCode() == FN_KEYCODE then
		local down = (eventType == types.keyDown)

		-- ZMK repeats keyDown while held; only transition on real edges.
		if down ~= M.held then
			M.held = down
			postFnTransition(down)
		end

		return true, {}
	end

	if M.held then
		addFn(e)

		local direction = DIRECTIONS[e:getKeyCode()]

		if direction then
			if M.debug then
				print(("fn-key: %d -> %d"):format(e:getKeyCode(), direction))
			end

			e:setKeyCode(direction)
		elseif M.debug then
			print(("fn-key: %d -> %s"):format(e:getKeyCode(), hs.inspect(e:getFlags())))
		end
	end

	return false
end)

M.tap:start()

-- A keyUp lost to sleep or lock leaves fn stuck on every keystroke.
M.watcher = hs.caffeinate.watcher.new(function(event)
	if event == hs.caffeinate.watcher.screensDidLock or event == hs.caffeinate.watcher.systemWillSleep then
		if M.held then
			M.held = false
			postFnTransition(false)
		end
	end
end)

M.watcher:start()

return M
