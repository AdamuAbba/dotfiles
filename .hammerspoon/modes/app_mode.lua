local keys = require("helpers.key_helper")
local apps = require("helpers.apps_helper")
local utils = require("helpers.utils")
local app_sublayer = hs.hotkey.modal.new()

local function launch_app(app_name, key_code, mod)
	local modifiers = mod or {}
	app_sublayer:bind(modifiers, key_code, function()
		hs.application.launchOrFocus(app_name)
		app_sublayer:exit()
	end)
end

--================================= enter app mode =============================================
hs.hotkey.bind(keys.hyper, "o", function()
	app_sublayer:enter()
end)
function app_sublayer:entered()
	utils.update_mode("APP MODE")
end

for _, v in pairs(apps) do
	launch_app(v.name, v.key_code, v.mod)
end

--================================= exit mode =============================================
app_sublayer:bind({}, "escape", function()
	app_sublayer:exit()
end)
function app_sublayer:exited()
	utils.update_mode("NORMAL MODE")
end
