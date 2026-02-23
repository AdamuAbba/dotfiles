local utils = require("helpers.utils")

---@class ScriptBinding
---@diagnostic disable-next-line: duplicate-doc-field
---@field key_code string Key used to trigger the script.
---@diagnostic disable-next-line: duplicate-doc-field
---@field mod table additional modifiers to use with the key code.
---@field script_func fun(): nil script function to execute.

---@class Apps
---@diagnostic disable-next-line: duplicate-doc-field
---@field Aerospace ScriptBinding
---@diagnostic disable-next-line: duplicate-doc-field
---@field Sketchybar ScriptBinding
---@diagnostic disable-next-line: duplicate-doc-field
---@field Simulator ScriptBinding

---@type Apps
local SCRIPTS = {
	Aerospace = {
		key_code = "a",
		mod = {},
		script_func = function()
			os.execute(utils.SCRIPTS .. "/aerospace/reload.sh")
		end,
	},

	Sketchybar = {
		key_code = "s",
		mod = {},
		script_func = function()
			os.execute(utils.SCRIPTS .. "/sketchybar/reload.sh")
		end,
	},
	Simulator = {
		key_code = "s",
		mod = { "shift" },
		script_func = function()
			os.execute(utils.SCRIPTS .. "/mac-os/restart_sim_app.sh")
		end,
	},
}

return SCRIPTS
