---@diagnostic disable: undefined-field
-- local Config = require("utils.class.config"):new()
---@type Wezterm
local wezterm = require "wezterm"

---@type Config
local config = wezterm.config_builder()

--============================================= events =============================================
require "events.gui-startup"
require "events.update-status"
require "events.config-reloaded"

--============================================= UI =============================================
local scheme = wezterm.get_builtin_color_schemes()["Dracula (Official)"]
scheme.background = "black"

config.color_schemes = {
  ["Dracula (Official)"] = scheme,
}
config.color_scheme = "Dracula (Official)"
wezterm.font_with_fallback {
  { family = "ShureTechMono Nerd Font", weight = "Regular" },
  { family = "JetBrainsMono Nerd Fon", weight = "Regular" },
}
config.default_prog = { "/bin/zsh" }
config.disable_default_key_bindings = true
config.font_size = 17.2
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = { left = 7.5, right = 0, top = 10, bottom = 0 }
config.clean_exit_codes = { 130 }
config.exit_behavior = "CloseOnCleanExit"
config.exit_behavior_messaging = "Verbose"
config.max_fps = 120
config.skip_close_confirmation_for_processes_named = {
  "bash",
  "sh",
  "zsh",
  "fish",
  "tmux",
  "nu",
  "cmd.exe",
  "pwsh.exe",
  "powershell.exe",
}
config.window_close_confirmation = "AlwaysPrompt"

return config
