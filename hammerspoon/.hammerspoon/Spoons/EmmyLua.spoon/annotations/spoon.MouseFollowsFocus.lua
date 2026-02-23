--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Set the mouse pointer to the center of the focused window whenever focus changes.
--
-- Additionally, if focused window moves when no mouse buttons are pressed, set the
-- mouse pointer to the new center.  This is intended to work with other utilities
-- which warp the focused window.
--
-- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/MouseFollowsFocus.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/MouseFollowsFocus.spoon.zip)
---@class spoon.MouseFollowsFocus
local M = {}
spoon.MouseFollowsFocus = M

-- Configures the spoon.
--
-- Parameters:
--  * configuration - a table containing the settings for onWindowMoved or onChangeOfScreenOnly:
function M:configure(configuration, ...) end

-- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
M.logger = nil

-- Starts updating the mouse position when window focus changes
--
-- Parameters:
--  * None
function M:start() end

-- Stops updating the mouse position when window focus changes
--
-- Parameters:
--  * None
function M:stop() end

-- Moves the mouse to the center of the given window unless it's already inside the window
--
-- Parameters:
--  * None
function M:updateMouse(window, ...) end

