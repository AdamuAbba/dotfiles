---@diagnostic disable: need-check-nil, undefined-field
local utils = require("helpers.utils")

hs.loadSpoon("SpoonInstall")
local KSheet = hs.loadSpoon("KSheet")
KSheet:init()
KSheet:bindHotkeys({
  hide = { {"ctrl"}, "[" },
})

-- downloaded and modified from https://github.com/FryJay/MenuHammer
-- I swear dude is a legend, respect 🫡
---@diagnostic disable-next-line: undefined-field
hs.loadSpoon("MenuHammer"):enter()
hs.dockicon.hide()

spoon.SpoonInstall:andUse("EmmyLua")

require("helpers.auto_cmds_events")

--============================================= watchers =============================================
require("watchers")

--========================== Debug zone =========================================
-- local keylogger = require("helpers.key_logger")
-- keylogger.keyTap:start()
-- keylogger.flagTap:start()

--================================== Do not re-order shit breaks ================
-- utils.initFocus()
