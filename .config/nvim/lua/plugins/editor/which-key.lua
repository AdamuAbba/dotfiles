return {
  "folke/which-key.nvim",
  ---@param _ any
  ---@param opts wk.Config
  opts = function(_, opts)
    opts.preset = "modern"
    ---@type wk.Win.opts
    opts.win = vim.tbl_deep_extend("force", opts.win or {}, {
      no_overlap = true,
      border = "rounded",
      height = { min = 13, max = 15 },
      title = true,
      title_pos = "center",
      zindex = 1000,
      wo = {
        winblend = 0,
      },
    })
    opts.layout = vim.tbl_deep_extend("force", opts.layout or {}, {
      width = { min = 20 },
      spacing = 6,
      align = "center",
    })
    opts.show_help = true
    opts.show_keys = true
    return opts
  end,
}
