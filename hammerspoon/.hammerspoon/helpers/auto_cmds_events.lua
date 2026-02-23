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
