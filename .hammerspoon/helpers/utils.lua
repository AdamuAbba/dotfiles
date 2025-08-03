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
---@diagnostic disable-next-line: duplicate-set-field
M.update_mode = function(msg)
	os.execute(M.SCRIPTS .. "/sketchybar/show_notification.sh '" .. msg .. "'")
end

---@class keycode_mapping
---@field key string # The key to bind
---@field key_code number # The key code to send when the key is pressed

---@summary Sends a sublayer bound system event using AppleScript to simulate a key press
---@param bindings keycode_mapping[]
---@param sublayer hs.hotkey.modal # The sublayer to bind the keys to
M.send_sublayer_sys_event = function(bindings, sublayer)
	for _, binding in ipairs(bindings) do
		sublayer:bind({}, binding.key, function()
			local script = string.format(
				[[
        tell application "System Events"
          key code %d
        end tell
      ]],
				binding.key_code
			)

			hs.osascript.applescript(script)
		end)
	end
end

return M
