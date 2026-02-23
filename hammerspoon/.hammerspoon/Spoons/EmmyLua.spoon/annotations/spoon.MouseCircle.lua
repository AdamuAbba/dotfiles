--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Draws a circle around the mouse pointer when a hotkey is pressed
--
-- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/MouseCircle.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/MouseCircle.spoon.zip)
---@class spoon.MouseCircle
local M = {}
spoon.MouseCircle = M

-- Binds hotkeys for MouseCircle
--
-- Parameters:
--  * mapping - A table containing hotkey modifier/key details for the following items:
--   * show - This will cause the mouse circle to be drawn
function M:bindHotkeys(mapping, ...) end

-- An `hs.drawing.color` table defining the colour of the circle. Defaults to red.
M.color = nil

-- Draws a circle around the mouse
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M:show() end

