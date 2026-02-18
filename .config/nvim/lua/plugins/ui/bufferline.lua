return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        diagnostics = false,
        indicator = {
          style = "none",
        },
        show_close_icon = false,
        show_buffer_close_icons = false,
      })
      return opts
    end,
  },
}
