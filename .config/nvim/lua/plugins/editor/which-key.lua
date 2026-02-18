return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    local custom_border = require("lib.icons").custom_border
    opts.preset = "helix"
    opts.plugins = vim.tbl_deep_extend("force", opts.plugins or {}, {
      marks = true,
      registers = true,
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
      spelling = {
        enabled = false,
      },
    })
    opts.icons = vim.tbl_deep_extend("force", opts.icons or {}, {
      breadcrumb = "»",
      group = "+",
      ellipsis = "…",
      separator = "│",
      mappings = false,
    })

    opts.win = vim.tbl_deep_extend("force", opts.win or {}, {
      no_overlap = true,
      border = custom_border,
      width = 31,
      height = { max = 35 },
      title = true,
      zindex = 1000,
      wo = {
        winblend = 0,
      },
    })
    opts.show_help = false
    opts.show_keys = true
    return opts
  end,
}
