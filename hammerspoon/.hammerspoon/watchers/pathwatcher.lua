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
  "~/Documents/dotfiles/hammerspoon/",
  "~/.config/aerospace/",
  "~/.config/ghostty/",
  "~/.config/neru/",
  "~/Documents/dotfiles/tmux/tmux.conf",
}

--- PathWatcher:start()
--- Method
--- Start PathWatcher
---
--- Parameters:
---  * None
function obj:start()
  self.watchers = {}
  self.watchers[self.watch_paths[1]] = hs.pathwatcher
    .new(self.watch_paths[1], function()
      utils.reloadHSConfig()
    end)
    :start()
  self.watchers[self.watch_paths[2]] = hs.pathwatcher
    .new(self.watch_paths[2], function()
      local output, status = hs.execute("/opt/homebrew/bin/aerospace reload-config")
      if status then
        utils:nerd_alert(string.format("Aerospace reloaded"))
      else
        utils:nerd_alert(string.format("Aerospace reload failed: %s", output))
      end
    end)
    :start()
  self.watchers[self.watch_paths[3]] = hs.pathwatcher
    .new(self.watch_paths[3], function()
      local ghostty_app = hs.application.find("Ghostty")
      ghostty_app:selectMenuItem("Reload Configuration")
      utils:nerd_alert(string.format("Ghostty reloaded"))
    end)
    :start()
  self.watchers[self.watch_paths[4]] = hs.pathwatcher
    .new(self.watch_paths[4], function()
      local output, status = hs.execute("/opt/homebrew/bin/neru config reload")
      if status then
        utils:nerd_alert(string.format("Neru reloaded"))
      else
        utils:nerd_alert(string.format("Neru reload failed: %s", output))
      end
    end)
    :start()
  self.watchers[self.watch_paths[5]] = hs.pathwatcher
    .new(self.watch_paths[5], function()
      local output, status = hs.execute(
        "/opt/homebrew/bin/tmux source-file /Users/abba/.config/tmux/tmux.conf && /opt/homebrew/bin/tmux display-message 'config reloaded'"
      )
      if status then
        utils:nerd_alert(string.format("tmux reloaded"))
      else
        utils:nerd_alert(string.format("tmux reload failed: %s", output))
      end
    end)
    :start()
  return self
end

return obj
