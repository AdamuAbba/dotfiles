return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = function()
      return {
        {
          "<c-f>",
          function()
            require("noice.lsp").scroll(4)
          end,
          desc = "Hover Scroll Down",
          silent = true,
          expr = true,
          mode = { "n", "i", "s" },
        },
        {
          "<c-b>",
          function()
            require("noice.lsp").scroll(-4)
          end,
          desc = "Hover Scroll up",
          silent = true,
          expr = true,
          mode = { "n", "i", "s" },
        },
      }
    end,
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
            row = "95%",
            col = "100%",
            anchor = "SE",
            offset = { row = 0, col = -2 },
          },
          size = {
            height = "1",
            width = "auto",
            max_height = 80,
            max_width = 80,
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
      })

      opts.lsp = vim.tbl_deep_extend("force", opts.lsp or {}, {
        progress = {
          enabled = false,
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
            throttle = 50,
          },
          view = nil,
          opts = {
            border = {
              style = custom_border,
            },
          },
        },
        hover = {
          enabled = true,
          silent = false,
          view = "hover",
          opts = {
            border = {
              style = custom_border,
            },
            lang = "markdown",
            replace = true,
            render = "markdown",
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
        enabled = false,
      }

      opts.presets = vim.tbl_deep_extend("force", opts.presets or {}, {
        bottom_search = false,
        lsp_doc_border = true,
      })
      return opts
    end,
  },
}
