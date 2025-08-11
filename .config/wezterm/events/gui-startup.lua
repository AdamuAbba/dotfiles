---@module "events.gui-startup"
---@author abba
---@license GNU-GPLv3
---@diagnostic disable: undefined-field

---@type Wezterm
local wezterm = require "wezterm"

-- Large window on startup
wezterm.on("gui-startup", function(_)
  local screen = wezterm.gui.screens().active
  local _, _, window = wezterm.mux.spawn_window {}
  local gui_window = window:gui_window()

  local width = screen.width * 0.98
  local height = screen.height * 0.94
  gui_window:set_inner_size(width, height)

  local dimensions = gui_window:get_dimensions()
  local x = (screen.width - dimensions.pixel_width) * 0.5
  local y = (screen.height - dimensions.pixel_height) * 0.8
  gui_window:set_position(x, y)
end)

-- Smaller floating window for later spawns
-- wezterm.on("window-created", function(window, _opts)
--   if wezterm.mux.get_window_count() == 1 then
--     return
--   end
--
--   local screen = wezterm.gui.screens().active
--   local gui_window = window:gui_window()
--
--   -- Lock the title and prevent programs from changing it
--   gui_window:set_title "FloatingTerm"
--
--   local width = screen.width * 0.7
--   local height = screen.height * 0.7
--   gui_window:set_inner_size(width, height)
--
--   local dimensions = gui_window:get_dimensions()
--   local x = (screen.width - dimensions.pixel_width) * 0.5
--   local y = (screen.height - dimensions.pixel_height) * 0.5
--   gui_window:set_position(x, y)
-- end)
--
