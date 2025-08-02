-- copied and modified from
-- https://github.com/kclejeune/system/blob/master/modules/home-manager/dotfiles/hammerspoon/init.lua
-- amazing stuff

local sendEscape = false
local lastMods = {}

local function controlKeyHandler()
	sendEscape = false
end

local controlKeyTimer = hs.timer.delayed.new(0.15, controlKeyHandler)

local function controlHandler(evt)
	local newMods = evt:getFlags()
	if lastMods["ctrl"] == newMods["ctrl"] then
		return false
	end

	if not lastMods["ctrl"] and newMods["ctrl"] then
		lastMods = newMods
		sendEscape = true
		controlKeyTimer:start()
	elseif lastMods["ctrl"] and not newMods["ctrl"] then
		lastMods = newMods
		controlKeyTimer:stop()
		if sendEscape then
			return true,
				{
					hs.eventtap.event.newKeyEvent({}, "escape", true),
					hs.eventtap.event.newKeyEvent({}, "escape", false),
				}
		end
	else
		lastMods = newMods
	end

	return false
end

hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, controlHandler):start()
