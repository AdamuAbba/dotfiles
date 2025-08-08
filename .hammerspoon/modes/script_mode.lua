local keys = require("helpers.key_helper")
local scripts = require("helpers.script_helper")
local utils = require("helpers.utils")
local script_sublayer = hs.hotkey.modal.new()

---@param binding ScriptBinding
local function run_script(binding)
	local modifiers = binding.mod or {}
	script_sublayer:bind(modifiers, binding.key_code, function()
		binding.script_func()
		script_sublayer:exit()
	end)
end

-- --================================= enter script mode =============================================
hs.hotkey.bind(keys.hyper, "s", function()
	script_sublayer:enter()
end)
function script_sublayer:entered()
	utils.update_mode("SCRIPT MODE")
end

for _, v in pairs(scripts) do
	run_script(v)
end

-- --================================= exit mode =============================================
script_sublayer:bind({}, "escape", function()
	script_sublayer:exit()
end)
function script_sublayer:exited()
	utils.update_mode("NORMAL MODE")
end
