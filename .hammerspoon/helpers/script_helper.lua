local utils = require("helpers.utils")

---@class ScriptBinding
---@diagnostic disable-next-line: duplicate-doc-field
---@field key_code string Key used to trigger the script.
---@field script_func fun(): nil script function to execute.

---@class Apps
---@field Aerospace ScriptBinding
---@field Sketchybar ScriptBinding

---@type Apps
local SCRIPTS = {
	Aerospace = {
		key_code = "a",
		script_func = function()
			os.execute(utils.SCRIPTS .. "/aerospace/reload.sh")
		end,
	},

	Sketchybar = {
		key_code = "k",
		script_func = function()
			os.execute(utils.SCRIPTS .. "/sketchybar/reload.sh")
		end,
	},
}

return SCRIPTS
