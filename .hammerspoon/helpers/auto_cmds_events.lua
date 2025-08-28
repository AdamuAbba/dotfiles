local utils = require("helpers.utils")

spoon.SpoonInstall:andUse("MouseFollowsFocus", {
	start = true,
	config = {
		onWindowMoved = true,
		onChangeOfScreenOnly = false,
	},
})

spoon.SpoonInstall:andUse("FadeLogo", {
	start = true,
	config = {
		image = hs.image.imageFromPath(utils.HOME .. "/Pictures/shy-face-1.png"),
		zoom = true,
	},
})

spoon.SpoonInstall:andUse("MouseCircle", {
	config = {
		color = utils.colors:to_rgb().purple,
	},
})

local wf = hs.window.filter.new():setDefaultFilter({})
wf:subscribe(hs.window.filter.windowFocused, function()
	spoon.MouseCircle:show()
end)
