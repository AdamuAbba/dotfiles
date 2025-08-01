--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Let users choose emojis by name/keyword
---@class spoon.Emojis
local M = {}
spoon.Emojis = M

-- Binds hotkeys for Emojis
--
-- Parameters:
--  * mapping - A table containing hotkey modifier/key details for the following items:
--   * toggle - This will toggle the emoji chooser
--
-- Returns:
--  * The Emojis object
function M:bindHotkeys(mapping, ...) end

