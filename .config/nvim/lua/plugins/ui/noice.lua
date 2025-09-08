return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.views = vim.tbl_deep_extend("force", opts.views or {}, {
        cmdline_popup = {
          position = {
            row = "40%",
            col = "50%",
          },
        },
        progress_with_border = {
          backend = "popup",
          border = {
            style = "rounded",
            padding = { 1, 1 },
          },
          position = {
            row = "100%",
            col = "100%",
            anchor = "SE",
            offset = { row = 0, col = -2 },
          },
          size = {
            width = "auto",
            height = "auto",
            max_width = 80,
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
      })

      opts.lsp = vim.tbl_deep_extend("force", opts.lsp or {}, {
        progress = {
          enabled = true,
          view = "progress_with_border",
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30,
        },
      })

      opts.presets = vim.tbl_deep_extend("force", opts.presets or {}, {
        bottom_search = false,
        lsp_doc_border = true,
      })
    end,
  },
}
