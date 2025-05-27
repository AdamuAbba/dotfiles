---@diagnostic disable: undefined-field
-- local Config = require("utils.class.config"):new()
-- return Config:add("config"):add "mappings"
local wezterm = require "wezterm"
local config = wezterm.config_builder()

--============================================= events =============================================
require "events.gui-startup"
require "events.update-status"

--============================================= UI =============================================
config.color_scheme = "Dracula (Official)"
config.font = wezterm.font("ShureTechMono Nerd Font", { weight = "Regular" })
config.font_size = 17.2
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
-- config.underline_thickness = "1pt"
-- config.underline_position = "-3pt"
config.window_padding = { left = 7.5, right = 0, top = 10, bottom = 0 }
config.clean_exit_codes = { 130 }
config.exit_behavior = "CloseOnCleanExit"
config.exit_behavior_messaging = "Verbose"
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
config.keys = {
  {
    key = "r",
    mods = "CMD|SHIFT",
    action = wezterm.action.ReloadConfiguration,
  },
}

return config
