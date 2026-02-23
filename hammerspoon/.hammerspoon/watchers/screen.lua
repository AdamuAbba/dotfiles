--- === Screen watcher ===
---
--- A global screen watcher object containing all screen related watchers in my HS config
---

local utils = require("helpers.utils")

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "ScreenWatcher"
obj.version = "1.0"
obj.author = "shytypes <shytypes1028@gmail.com>"
obj.homepage = ""
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- ScreenWatcher:start()
--- Method
--- Start ScreenWatcher
---
--- Parameters:
---  * None
function obj:start()
	obj:stop() -- stop existing watcher if any
	local function watcher_function()
		local path = os.getenv("HOME") .. "/.workspace_mode"
		local mode = (#hs.screen.allScreens() > 1) and "desktop" or "laptop"
		local file = io.open(path, "w")
		if file then
			file:write(mode)
			file:close()
		end
		-- os.execute("/usr/bin/env" .. " " .. utils.SCRIPTS .. "/sketchybar/reload.sh")
	end

	self.watcher = hs.screen.watcher.new(watcher_function):start()
	return self
end

function obj:stop()
	if self.watcher then
		self.watcher:stop()
		self.watcher = nil
	end
end
return obj
