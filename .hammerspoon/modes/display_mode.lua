local keys = require("helpers.key_helper")
local utils = require("helpers.utils")
local display_sublayer = hs.hotkey.modal.new()

--================================= enter display mode =============================================
hs.hotkey.bind(keys.hyper, "b", function()
	display_sublayer:enter()
end)
function display_sublayer:entered()
	utils.update_mode("DISPLAY MODE")
end

--================================= Mode bindings =============================================
-- increase brightness
display_sublayer:bind({}, "k", function()
	local screens = hs.screen.allScreens()

	if screens and #screens == 1 then
		local only = screens[1]
		local current = only:getBrightness()
		local new = math.min(current + 0.2, 1)
		only:setBrightness(new)
		local percent = math.floor(only:getBrightness() * 100)
		hs.alert.show(string.format("󰃞  %d%%", percent))
		return
	end

	local focused = hs.screen.mainScreen()
	for _, screen in ipairs(screens or {}) do
		if screen ~= focused then
			local current = screen:getBrightness()
			local new = math.min(current + 0.2, 1)
			screen:setBrightness(new)
			local percent = math.floor(screen:getBrightness() * 100)
			hs.alert.show(string.format("󰃞  %d%%", percent))
		end
	end
end)

-- decrease brightness
display_sublayer:bind({}, "j", function()
	local screens = hs.screen.allScreens()

	if screens and #screens == 1 then
		local only = screens[1]
		local current = only:getBrightness()
		local new = math.min(current - 0.2, 1)
		only:setBrightness(new)
		local percent = math.floor(only:getBrightness() * 100)
		hs.alert.show(string.format("󰃞  %d%%", percent))
		return
	end

	local focused = hs.screen.mainScreen()
	for _, screen in ipairs(screens or {}) do
		if screen ~= focused then
			local current = screen:getBrightness()
			local new = math.min(current - 0.2, 1)
			screen:setBrightness(new)
			local percent = math.floor(screen:getBrightness() * 100)
			hs.alert.show(string.format("󰃞  %d%%", percent))
		end
	end
end)

--================================= exit mode =============================================
display_sublayer:bind({}, "escape", function()
	display_sublayer:exit()
end)
function display_sublayer:exited()
	utils.update_mode("NORMAL MODE")
end
