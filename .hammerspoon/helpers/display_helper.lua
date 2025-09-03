local utils = require("helpers.utils")

local m = {}
-- increase brightness
m.increase_brightness = function()
	local screens = hs.screen.allScreens()

	if screens and #screens == 1 then
		local only = screens[1]
		local current = only:getBrightness()
		local new = math.min(current + 0.2, 1)
		only:setBrightness(new)
		local percent = math.floor(only:getBrightness() * 100)
		utils:nerd_alert(string.format("󰃠 %d%%  ", percent))
		return
	end

	local focused = hs.screen.mainScreen()
	for _, screen in ipairs(screens or {}) do
		if screen ~= focused then
			local current = screen:getBrightness()
			local new = math.min(current + 0.2, 1)
			screen:setBrightness(new)
			local percent = math.floor(screen:getBrightness() * 100)
			utils:nerd_alert(string.format("󰃠 %d%%  ", percent))
		end
	end
end

-- decrease brightness
m.decrease_brightness = function()
	local screens = hs.screen.allScreens()

	if screens and #screens == 1 then
		local only = screens[1]
		local current = only:getBrightness()
		local new = math.min(current - 0.2, 1)
		only:setBrightness(new)
		local percent = math.floor(only:getBrightness() * 100)
		utils:nerd_alert(string.format("󰃠  %d%%  ", percent))
		return
	end

	local focused = hs.screen.mainScreen()
	for _, screen in ipairs(screens or {}) do
		if screen ~= focused then
			local current = screen:getBrightness()
			local new = math.min(current - 0.2, 1)
			screen:setBrightness(new)
			local percent = math.floor(screen:getBrightness() * 100)
			utils:nerd_alert(string.format("󰃠  %d%%  ", percent))
		end
	end
end

return m
