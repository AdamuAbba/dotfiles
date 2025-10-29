return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        always_show_bufferline = true,
        indicator = {
          style = "none",
        },
        color_icons = true,
      })
      return opts
    end,
  },
}
