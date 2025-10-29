--- === PathWatcher ===
---
--- A global patch watcher object containing all path related watchers in my HS config
---
local utils = require("helpers.utils")

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "PathWatcher"
obj.version = "1.0"
obj.author = "shytypes <shytypes1028@gmail.com>"
obj.homepage = ""
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- pathwatcher.watch_paths
--- Variable
--- List of directories to watch for changes, defaults to hs.configdir
obj.watch_paths = {
	hs.configdir,
	-- aerospace config directory
	"~/.config/aerospace/",
}

--- PathWatcher:start()
--- Method
--- Start PathWatcher
---
--- Parameters:
---  * None
function obj:start()
	self.watchers = {}
	self.watchers[self.watch_paths[1]] = hs.pathwatcher.new(self.watch_paths[1], hs.reload):start()
	self.watchers[self.watch_paths[2]] = hs.pathwatcher
		.new(self.watch_paths[2], function()
			local output, status = hs.execute("/opt/homebrew/bin/aerospace reload-config")
			if status then
				utils:nerd_alert(string.format(" Aerospace config reloaded"))
			else
				utils:nerd_alert(string.format(" Aerospace config reload failed: %s", output))
			end
		end)
		:start()
	return self
end

return obj
