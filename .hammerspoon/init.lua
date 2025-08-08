hs.loadSpoon("SpoonInstall")

-- downloaded and modified from https://github.com/FryJay/MenuHammer
-- i swear dude is a legend, respect 🫡
---@diagnostic disable-next-line: undefined-field
hs.loadSpoon("MenuHammer"):enter()

spoon.SpoonInstall:andUse("EmmyLua")

require("pickers.app_picker")
require("pickers.emoji_picker")
require("helpers.reload_config")

-- local keylogger = require("helpers.key_logger")
--========================== Debug zone =========================================
-- keylogger.keyTap:start()
-- keylogger.flagTap:start()

--================================== Do not re-order...shit breaks ================
-- require("helpers.caps2esc")
