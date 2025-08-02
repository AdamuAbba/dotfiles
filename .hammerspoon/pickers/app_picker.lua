spoon.SpoonInstall:andUse("Seal", {
	hotkeys = { show = { { "cmd" }, "space" } },
	fn = function(s)
		s:loadPlugins({
			"apps",
			"calc",
			"screencapture",
			"useractions",
		})
		s.plugins.useractions.actions = {
			["Hammerspoon docs webpage"] = {
				url = "http://hammerspoon.org/docs/",
				icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
			},
		}
		s:refreshAllCommands()
	end,
	start = true,
})
