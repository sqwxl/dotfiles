-- Map F13 to the macOS fn / Globe modifier, and put Swish's direction keys on
-- h/c/t/n.
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

-- Real fn's virtual keycode. A flagsChanged carries the keycode of the
-- modifier that changed; without it downstream state machines see 0 ("a").
local FN_MODIFIER_KEYCODE = 0x3F

-- Nobody holds fn this long, so a hold still open after it is a lost keyUp.
local HOLD_TIMEOUT = 5

M.debug = false
M.held = false

-- Swish's arrow hotkeys are a fixed enum (arrows/hjkl/ijkl/wasd/dvorak), so
-- arbitrary letters cannot be configured there. Leave Swish on "hjkl" and
-- rewrite keycodes here instead.
--
-- Targets are hardcoded because Swish matches raw virtual keycodes, which are
-- QWERTY positions regardless of the active layout. Sources go through
-- hs.keycodes.map so they follow the layout: on the Kinesis the host is US and
-- ZMK supplies Dvorak, on the built-in the host layout is Dvorak itself, and
-- the physical key differs between the two.
local SWISH = { left = 4, down = 38, up = 40, right = 37 }
local BINDINGS = { h = "left", c = "up", t = "down", n = "right" }

local directions = {}

local function rebuildDirections()
	directions = {}

	for character, direction in pairs(BINDINGS) do
		local keycode = hs.keycodes.map[character]

		if keycode then
			directions[keycode] = SWISH[direction]
		end
	end
end

rebuildDirections()
hs.keycodes.inputSourceChanged(rebuildDirections)

-- Rebuild the current modifier state with fn forced on or off, so a real
-- Cmd or Shift held across the F13 press survives the synthetic event.
--
-- Derived from the F13 event by copy() rather than built with newEvent(), so it
-- inherits that event's source, keyboard type and device-dependent modifier
-- bits. A newEvent() has no source at all, which is a plausible reason a
-- downstream state machine would mistrack it.
local function postFnTransition(down, source)
	local raw = source and source:rawFlags() or (hs.eventtap.checkKeyboardModifiers(true)._raw or 0)
	raw = down and (raw | FN_MASK) or (raw & ~FN_MASK)

	local event = source and source:copy() or hs.eventtap.event.newEvent()

	event:setType(types.flagsChanged):rawFlags(raw):setKeyCode(FN_MODIFIER_KEYCODE):post()

	if M.debug then
		print(("fn-key: post fn=%s raw=0x%X copied=%s"):format(tostring(down), raw, tostring(source ~= nil)))
	end
end

local function release()
	if M.held then
		M.held = false
		postFnTransition(false)
	end
end

-- A keyUp lost to secure input, a focus steal, or a tap disabled by timeout
-- otherwise leaves fn stuck on every keystroke until the key is tapped again.
--
-- ponytail: fixed timeout rather than tracking the physical key; there is no
-- API to read F13's state. Raise HOLD_TIMEOUT if a real hold ever trips it.
local function armDeadman(down)
	if M.deadman then
		M.deadman:stop()
		M.deadman = nil
	end

	if down then
		M.deadman = hs.timer.doAfter(HOLD_TIMEOUT, release)
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
			postFnTransition(down, e)
			armDeadman(down)
		end

		return true, {}
	end

	if eventType == types.flagsChanged and M.debug then
		print(
			("fn-key: saw flagsChanged raw=0x%X keycode=%d held=%s"):format(
				e:rawFlags(),
				e:getKeyCode(),
				tostring(M.held)
			)
		)
	end

	if M.held then
		addFn(e)
	end

	-- Keyed off the flag rather than M.held, so the built-in keyboard's real fn
	-- gets the same remap as the forged one.
	if e:getFlags().fn then
		local direction = directions[e:getKeyCode()]

		if direction then
			if M.debug then
				print(("fn-key: %d -> %d"):format(e:getKeyCode(), direction))
			end

			e:setKeyCode(direction)
		end
	end

	return false
end)

M.tap:start()

-- A keyUp lost to sleep or lock leaves fn stuck on every keystroke.
M.watcher = hs.caffeinate.watcher.new(function(event)
	if event == hs.caffeinate.watcher.screensDidLock or event == hs.caffeinate.watcher.systemWillSleep then
		release()
	end
end)

M.watcher:start()

return M
