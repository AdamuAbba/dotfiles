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
	"~/.config/aerospace/",
	"~/.config/ghostty/",
	-- "~/.config/tmux/",
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
	self.watchers[self.watch_paths[3]] = hs.pathwatcher
		.new(self.watch_paths[3], function()
			local ghostty_app = hs.application.find("Ghostty")
			ghostty_app:selectMenuItem("Reload Configuration")
			utils:nerd_alert(string.format("󰊠 Ghostty config reloaded"))
		end)
		:start()
	-- self.watchers[self.watch_paths[4]] = hs.pathwatcher
	-- 	.new(self.watch_paths[4], function()
	-- 		local output, status = hs.execute("/opt/homebrew/bin/tmux source-file ~/.config/tmux/tmux.conf")
	-- 		if status then
	-- 			utils:nerd_alert(string.format(" tmux config sourced"))
	-- 		else
	-- 			utils:nerd_alert(string.format(" tmux config reload failed: %s", output))
	-- 		end
	-- 	end)
	-- 	:start()
	return self
end

return obj
