--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Hammerspoon Search
--
-- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/HSearch.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/HSearch.spoon.zip)
---@class spoon.HSearch
local M = {}
spoon.HSearch = M

-- Load new sources from `HSearch.search_path`, the search_path defaults to `~/.hammerspoon/private/hsearch_dir` and the HSearch Spoon directory. Only useful for debugging purposes.
--
-- Parameters:
--  * None
-- 
function M:loadSources() end

-- Trigger new source according to `hs.chooser`'s query string and keyword. Only useful for debugging purposes.
--
-- Parameters:
--  * None
-- 
function M:switchSource() end

-- Toggle the display of HSearch
--
-- Parameters:
--  * None
-- 
function M:toggleShow() end

