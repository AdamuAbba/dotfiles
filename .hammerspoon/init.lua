hs.loadSpoon("SpoonInstall")

-- downloaded and modified from https://github.com/FryJay/MenuHammer
-- i swear dude is a legend, respect 🫡
---@diagnostic disable-next-line: undefined-field
hs.loadSpoon("MenuHammer"):enter()
hs.dockicon.hide()

spoon.SpoonInstall:andUse("EmmyLua")

require("helpers.auto_cmds_events")

--============================================= watchers =============================================
require("watchers")

-- local keylogger = require("helpers.key_logger")
--========================== Debug zone =========================================
-- keylogger.keyTap:start()
-- keylogger.flagTap:start()

--================================== Do not re-order...shit breaks ================
