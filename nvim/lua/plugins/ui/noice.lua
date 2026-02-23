return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = function(_, opts)
      local custom_border = require("lib.icons").custom_border
      opts.views = vim.tbl_deep_extend("force", opts.views or {}, {
        cmdline_popup = {
          border = {
            style = custom_border,
          },
          position = {
            row = "40%",
            col = "50%",
          },
        },
        progress_with_border = {
          backend = "popup",
          border = {
            style = custom_border,
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
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
          view = nil,
          ---@type NoiceViewOptions
          opts = {
            border = {
              style = custom_border,
            },
          },
        },
        hover = {
          enabled = true,
          silent = false,
          view = nil,
          ---@type NoiceViewOptions
          opts = {
            border = {
              style = custom_border,
            },
          },
        },
        message = {
          enabled = true,
          view = "notify",
          opts = {
            border = {
              style = custom_border,
            },
          },
        },
        documentation = {
          view = "hover",
          ---@type NoiceViewOptions
          opts = {
            border = {
              style = custom_border,
            },
            lang = "markdown",
            replace = true,
            render = "markdown",
            format = {
              "{message}",
            },
            win_options = { concealcursor = "n", conceallevel = 3 },
          },
        },
      })

      opts.notify = {
        enabled = true,
      }

      opts.presets = vim.tbl_deep_extend("force", opts.presets or {}, {
        bottom_search = false,
        lsp_doc_border = true,
      })
      return opts
    end,
  },
}
