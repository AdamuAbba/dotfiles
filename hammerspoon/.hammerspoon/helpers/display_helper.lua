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

local menu_bar_revealed = false
local saved_mouse_pos = nil

local function post_mouse_move(x, y)
	local event = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.mouseMoved, { x = x, y = y })
	event:post()
end

m.toggle_menu_bar = function()
	local win = hs.window.focusedWindow()
	if win and win:isFullScreen() then
		if menu_bar_revealed and saved_mouse_pos then
			local restore = saved_mouse_pos
			saved_mouse_pos = nil
			menu_bar_revealed = false
			hs.mouse.absolutePosition(restore)
			post_mouse_move(restore.x, restore.y)
		else
			saved_mouse_pos = hs.mouse.absolutePosition()
			local screen = hs.screen.mainScreen()
			local frame = screen:fullFrame()
			local center_x = frame.x + frame.w / 2

			hs.mouse.absolutePosition({ x = center_x, y = frame.y + 5 })
			post_mouse_move(center_x, frame.y + 5)

			hs.timer.doAfter(0.05, function()
				hs.mouse.absolutePosition({ x = center_x, y = frame.y })
				post_mouse_move(center_x, frame.y)
			end)

			menu_bar_revealed = true
		end
	else
		os.execute(utils.SCRIPTS .. "/mac-os/toggle_menu_bar.sh")
	end
end

return m
