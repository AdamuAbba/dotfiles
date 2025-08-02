---@summary Keybindings for running utility scripts like Aerospace, Sketchybar, etc

local utils = require("helpers.utils")

---@class ScriptBinding
---@field key_code string Key used to trigger the script.
---@field script_func fun(): nil script function to execute.

---@type table<string, ScriptBinding>
local SCRIPTS = {
	---@type ScriptBinding
	Aerospace = {
		key_code = "a",
		script_func = function()
			os.execute(utils.SCRIPTS .. "/aerospace/reload.sh")
		end,
	},

	---@type ScriptBinding
	Sketchybar = {
		key_code = "k",
		script_func = function()
			os.execute(utils.SCRIPTS .. "/sketchybar/reload.sh")
		end,
	},
}

return SCRIPTS
