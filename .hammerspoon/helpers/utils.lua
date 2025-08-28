local M = {}

--- Absolute path to the user's home directory
M.HOME = os.getenv("HOME") or ""

--- Path to the user's custom scripts directory
M.SCRIPTS = M.HOME .. "/.config/scripts"

--- Path to the dotfiles directory
M.DOTFILES = M.HOME .. "/Documents/dotfiles"

--- Sends a mode update notification using Sketchybar
---@param msg string Message to display in the notification
function M:update_mode(msg)
	os.execute(self.SCRIPTS .. "/sketchybar/show_notification.sh '" .. msg .. "'")
end

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

M.hex_to_rgb = function(hex)
	hex = hex:gsub("#", "")
	local r = tonumber(hex:sub(1, 2), 16) / 255
	local g = tonumber(hex:sub(3, 4), 16) / 255
	local b = tonumber(hex:sub(5, 6), 16) / 255
	return { red = r, green = g, blue = b, alpha = 1 }
end

function M.colors:to_rgb()
	local rgb_table = {}
	for name, hex in pairs(self) do
		if type(hex) == "string" then
			rgb_table[name] = M.hex_to_rgb(hex)
		end
	end
	return rgb_table
end

function M:nerd_alert(msg, opts)
	opts = opts or {}
	local styled = hs.styledtext.new(msg, {
		font = { name = "JetBrainsMono Nerd Font", size = opts.size or 30 },
		color = opts.color or self.colors:to_rgb().green,
		traits = { bold = true },
	})
	hs.alert.show(styled, {
		strokeColor = { alpha = 0 },
		fillColor = { alpha = 0 },
		textStyle = {},
		radius = 0,
	}, opts.screen, opts.duration or 2)
end

return M
