return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = function()
      return {}
    end,
    opts = function(_, opts)
      local custom_border = require("lib.icons").custom_border
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        borderchars = {
          custom_border[2], -- top
          custom_border[8], -- right
          custom_border[6], -- bottom
          custom_border[4], -- left
          custom_border[1], -- top-left
          custom_border[3], -- top-right
          custom_border[5], -- bottom-right
          custom_border[7], -- bottom-left
        },
      })
      return opts
    end,
  },
}
