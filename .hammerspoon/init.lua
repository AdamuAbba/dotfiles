hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("EmmyLua")

require("modes.script_mode")
require("modes.app_mode")
require("pickers.app_picker")
require("pickers.emoji_picker")
require("helpers.reload_config")

local keylogger = require("helpers.key_logger")
--========================== Debug zone =========================================
keylogger.keyTap:start()
keylogger.flagTap:start()

--================================== Do not re-order...shit breaks ================
require("helpers.caps2esc")
