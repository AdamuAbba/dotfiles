--- === caffeinate watcher ===
---
--- A global screen watcher object containing system power states related watchers in my HS config
---

local utils = require("helpers.utils")

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "caffeinateWatcher"
obj.version = "1.0"
obj.author = "shytypes <shytypes1028@gmail.com>"
obj.homepage = ""
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- CaffeinateWatcher:start()
--- Method
--- Start caffeinateWatcher
---
--- Parameters:
---  * None
function obj:start()
	local function watcher_function(event)
		if event == hs.caffeinate.watcher.screensDidUnlock then
			os.execute("/usr/bin/env" .. " " .. utils.SCRIPTS .. "/sketchybar/reload.sh")
		end
	end

	self.watcher = hs.caffeinate.watcher.new(watcher_function):start()
	return self
end

return obj
