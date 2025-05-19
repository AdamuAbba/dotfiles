---@diagnostic disable: undefined-global
require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})

require("starship"):setup()

require("copy-file-contents"):setup({
	append_char = "\n",
	notification = true,
})
