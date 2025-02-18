-- local Config = require("utils.class.config"):new()
--
-- require "events.gui-startup"
-- require "events.update-status"
-- require "events.format-tab-title"
-- require "events.new-tab-button-click"
-- require "events.augment-command-palette"
--
-- return Config:add("config"):add "mappings"
local wezterm = require "wezterm"
local config = wezterm.config_builder()
local mux = wezterm.mux

config.color_scheme = "Dracula (Official)"
config.font = wezterm.font("ShureTechMono Nerd Font", { weight = "Regular" })
config.font_size = 17
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

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

wezterm.on("gui-startup", function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config
