---@class ConfigUtils
local M = {}

--- Absolute path to the user's home directory
---@type string
M.HOME = os.getenv("HOME") or ""

--- Path to the user's custom scripts directory
---@type string
M.SCRIPTS = M.HOME .. "/.config/scripts"

--- Sends a mode update notification using Sketchybar
---@param msg string: The message to display in the notification
M.update_mode = function(msg)
	os.execute(M.SCRIPTS .. "/sketchybar/show_notification.sh '" .. msg .. "'")
end

return M
