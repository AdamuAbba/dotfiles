return {
  {
    "mawkler/modicator.nvim",
    dependencies = {
      "zenbones-theme/zenbones.nvim",
    },
    opts = function(_, opts)
      opts.show_warnings = false
      opts.highlights = {
        defaults = {
          bold = true,
          italic = true,
        },
        use_cursorline_background = false,
      }
      opts.integration = vim.tbl_deep_extend("force", opts.integration or {}, {
        lualine = {
          enabled = true,
        },
      })
      return opts
    end,
  },
}
