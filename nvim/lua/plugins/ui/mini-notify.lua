return {
  {
    "nvim-mini/mini.notify",
    version = false,
    config = function()
      local icons = require("lib.icons")

      local win_config = function()
        local has_statusline = vim.o.laststatus > 0
        local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
        return {
          anchor = "SE",
          border = icons.custom_border,
          col = vim.o.columns,
          row = vim.o.lines - pad,
        }
      end

      require("mini.notify").setup({
        content = {
          format = function(notif)
            return " " .. notif.msg .. " "
          end,

          sort = function(notif_arr)
            table.sort(notif_arr, function(a, b)
              return a.ts_update > b.ts_update
            end)
            return notif_arr
          end,
        },

        lsp_progress = {
          enable = true,
          level = "INFO",
          duration_last = 1500,
        },

        window = {
          config = win_config,
          max_width_share = 0.382,
          winblend = 0,
        },
      })

      vim.notify = MiniNotify.make_notify({
        ERROR = { duration = 4000, hl_group = "DiagnosticError" },
        WARN = { duration = 4000, hl_group = "DiagnosticWarn" },
        INFO = { duration = 4000, hl_group = "DiagnosticInfo" },
        DEBUG = { duration = 0, hl_group = "DiagnosticHint" },
        TRACE = { duration = 0, hl_group = "DiagnosticOk" },
        OFF = { duration = 0, hl_group = "MiniNotifyNormal" },
      })
    end,
  },
}
