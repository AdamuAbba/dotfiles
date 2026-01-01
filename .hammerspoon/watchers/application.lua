--- === application watcher ===
---
--- A global application watcher object containing all application related watchers in my HS config
---

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "ApplicationWatcher"
obj.version = "1.0"
obj.author = "shytypes <shytypes1028@gmail.com>"
obj.homepage = ""
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.appsToCenter = {
	"Finder",
	"Karabiner-Elements",
	"Hammerspoon",
	"Free Download Manager",
	"Activity Monitor",
	"The Unarchiver",
	"Safari",
	"Ghostty",
	"Zen",
	"Stremio",
	"Figma",
	"Xcode",
	"Bitwarden",
}

--- ApplicationWatcher:start()
--- Method
--- Start ApplicationWatcher
---
--- Parameters:
---  * None
function obj:start()
	obj:stop() -- stop existing watcher if any
	local appsToCenter = self.appsToCenter

	local function watcher_function(name, event, app)
		if not (event == hs.application.watcher.launched or event == hs.application.watcher.activated) then
			return
		end

		for _, target in ipairs(appsToCenter) do
			if name == target then
				hs.timer.doAfter(0.2, function()
					local win = app:mainWindow() or hs.window.frontmostWindow()
					if win and win:isStandard() then
						win:centerOnScreen(nil, true, 0.2)
						if win:isMaximizable() then
							win:maximize(0.2)
						end
					end
				end)
				break
			end
		end
	end

	local w = hs.application.watcher.new(watcher_function)
	w:start()
	self.watcher = w
	return self
end

function obj:stop()
	if self.watcher then
		self.watcher:stop()
		self.watcher = nil
	end
end

return obj
