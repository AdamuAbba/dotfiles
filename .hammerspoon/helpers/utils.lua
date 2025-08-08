--- custom Dracula color palette.
---@class DraculaColors
---@field background string
---@field current_line string
---@field selection string
---@field foreground string
---@field comment string
---@field cyan string
---@field green string
---@field orange string
---@field pink string
---@field glossy_pink string
---@field purple string
---@field red string
---@field yellow string
---@field white string
---@field black string

--- Module for configuration utilities
---@class ConfigUtils
---@field HOME string
---@field SCRIPTS string
---@field update_mode fun(msg: string)
---@field colors DraculaColors

local M = {}

--- Absolute path to the user's home directory
M.HOME = os.getenv("HOME") or ""

--- Path to the user's custom scripts directory
M.SCRIPTS = M.HOME .. "/.config/scripts"

--- Sends a mode update notification using Sketchybar
---@param msg string Message to display in the notification
M.update_mode = function(msg)
	os.execute(M.SCRIPTS .. "/sketchybar/show_notification.sh '" .. msg .. "'")
end

---@type DraculaColors
M.colors = {
	background = "#000000",
	current_line = "#44475a",
	selection = "#44475a",
	foreground = "#f8f8f2",
	comment = "#6272a4",
	cyan = "#8be9fd",
	green = "#50fa7b",
	orange = "#ffb86c",
	glossy_pink = "#DD29D4",
	pink = "#ff79c6",
	purple = "#bd93f9",
	red = "#ff0000",
	-- red = "#ff5555",
	yellow = "#f1fa8c",
	white = "#ffffff",
	black = "#000000",
}

---@type ConfigUtils
return M
