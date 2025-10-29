---@module "events.update-status"
---@diagnostic disable: undefined-field
local wezterm = require "wezterm"

local function center_window_once(window)
  wezterm.GLOBAL.windows_centered = wezterm.GLOBAL.windows_centered or {}

  local window_id = window:window_id() .. ""
  if wezterm.GLOBAL.windows_centered[window_id] then
    return
  end

  local screen = wezterm.gui.screens().active

  local width = screen.width * 0.85
  local height = screen.height * 0.85

  window:set_inner_size(width, height)

  local dimensions = window:get_dimensions()
  local x = (screen.width - dimensions.pixel_width) * 0.5
  local y = (screen.height - dimensions.pixel_height) * 0.5

  wezterm.GLOBAL.windows_centered[window_id] = true

  window:set_position(x, y)
end

wezterm.on("update-status", function(window)
  center_window_once(window)
  -- local leader = ""
  -- if window:leader_is_active() then
  --   leader = "LEADER"
  -- end
  -- window:set_right_status(leader)
end)
