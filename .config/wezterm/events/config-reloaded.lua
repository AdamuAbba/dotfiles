---@module "events.config-reloaded"
---@diagnostic disable: undefined-field
local wezterm = require "wezterm"

wezterm.on("window-config-reloaded", function(window, _)
  window:toast_notification("wezterm", "configuration reloaded!", nil, 4000)
end)
