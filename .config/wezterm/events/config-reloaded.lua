---@module "events.config-reloaded"
---@diagnostic disable: undefined-field
local wezterm = require "wezterm"

wezterm.on("window-config-reloaded", function(_, _)
  os.execute '/opt/homebrew/bin/sketchybar --trigger user_notification LABEL="wezterm  reloaded" && sleep 3 && /opt/homebrew/bin/sketchybar --trigger user_notification LABEL="NORMAL MODE"'
end)
