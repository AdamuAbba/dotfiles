---@module "events.gui-startup"
---@author sravioli
---@license GNU-GPLv3

local wezterm = require "wezterm"
local mux = wezterm.mux
local config = {}

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)
