---@diagnostic disable: missing-fields
return {
  {
    "rachartier/tiny-cmdline.nvim",
    config = function()
      local tiny_cmdline = require("tiny-cmdline")
      tiny_cmdline.setup({
        width = {
          value = "40%",
          min = 40,
          max = 80,
        },
        position = {
          x = "50%",
          y = "38%",
        },
        border = "rounded",
        menu_col_offset = 3,
        native_types = {},
        title = {
          enabled = true,
          pos = "center",
        },
        on_reposition = nil
      })
    end,
  },
}
