---@module "events.gui-startup"
---@author abba
---@license GNU-GPLv3
---@diagnostic disable: undefined-field

local wezterm = require "wezterm"

-- wezterm.on("gui-startup", function(cmd)
--   local _, _, window = mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)

wezterm.on("gui-startup", function()
  local screen = wezterm.gui.screens().active
  local _, _, window = wezterm.mux.spawn_window {}

  local gui_window = window:gui_window()

  -- Set dimensions to 98% of current screen size
  -- The actual dimensions will be a bit bigger if we take into
  -- account the decorations on top
  local width = screen.width * 0.98
  local height = screen.height * 0.94

  gui_window:set_inner_size(width, height)

  -- Position the window at the center of the screen
  local dimensions = gui_window:get_dimensions()
  local x = (screen.width - dimensions.pixel_width) * 0.5
  local y = (screen.height - dimensions.pixel_height) * 0.8

  gui_window:set_position(x, y)
end)
