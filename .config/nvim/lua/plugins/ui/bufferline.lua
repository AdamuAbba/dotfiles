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
        show_close_icon = false,
        show_buffer_close_icons = false,
        color_icons = true,
        separator_style = { "", "" },
      })
      return opts
    end,
  },
}
