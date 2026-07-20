---@diagnostic disable: undefined-field, undefined-global
return {
  {
    "folke/snacks.nvim",
    keys = function()
      --============================================= Notification =============================================
      return {}
    end,
    ---@param opts snacks.Config
    opts = function(_, opts)
      local custom_border = require("lib.icons").custom_border

      --============================================= gitbrowse =============================================
      opts.gitbrowse = {
        enabled = false,
      }
      --============================================= bigfile =============================================
      opts.bigfile = {
        enabled = false,
      }
      --============================================= animate =============================================
      opts.animate = vim.tbl_deep_extend("force", opts.animate or {}, {
        enabled = true,
      })

      --============================================= input =============================================
      opts.input = vim.tbl_deep_extend("force", opts.input or {}, {
        enabled = true,
        win = {
          border = custom_border,
          backdrop = false,
          position = "float",
          relative = "cursor",
          title_pos = "left",
          row = -3,
          col = 0,
          b = {
            completion = true,
          },
        },
      })

      --============================================= scope =============================================
      opts.scope = {
        enabled = false,
      }

      --============================================= notifier =============================================
      opts.notifier = {
        enabled = false,
      }

      --============================================= words =============================================
      opts.words = {
        enabled = false,
      }

      --============================================= indent =============================================
      opts.indent = vim.tbl_deep_extend("force", opts.indent or {}, {
        enabled = true,
        priority = 1,
        char = "╎",
        only_scope = false,
        only_current = false,
        -- animate scopes. Enabled by default for Neovim >= 0.10
        -- Works on older versions but has to trigger redraws during animation.
        ---@class snacks.indent.animate: snacks.animate.Config
        ---@diagnostic disable-next-line: duplicate-doc-field
        ---@field enabled? boolean
        --- * out: animate outwards from the cursor
        --- * up: animate upwards from the cursor
        --- * down: animate downwards from the cursor
        --- * up_down: animate up or down based on the cursor position
        ---@diagnostic disable-next-line: duplicate-doc-field
        ---@field style? "out"|"up_down"|"down"|"up"
        animate = {
          enabled = true,
          style = "out",
          easing = "linear",
          duration = {
            step = 40,
            total = 1000,
          },
        },
        ---@class snacks.indent.Scope.Config: snacks.scope.Config
        scope = {
          enabled = true,
          priority = 200,
          char = "╎",
          underline = false,
          only_current = false,
          ---@type string|string[] hl group for scopes
          hl = "SnacksIndentScope",
        },
        chunk = {
          enabled = true,
          only_current = false,
          priority = 200,
          ---@type string|string[] hl group for chunk scopes
          hl = "SnacksIndentChunk",
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "",
            vertical = "|",
            arrow = ">",
          },
        },
        -- filter for buffers to enable indent guides
        ---@param buf number
        filter = function(buf, _)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      })

      --============================================= lazygit =============================================
      opts.lazygit = {
        enabled = false,
      }

      --============================================= explorer =============================================
      opts.explorer = {
        enabled = false,
      }

      --============================================= picker =============================================
      opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, {
        enabled = false,
        hidden = true,
        layout = {
          cycle = false,
          layout = {
            backdrop = false,
          },
        },
        layouts = {},
        sources = {
          explorer = {},
        },
      })
      --============================================= zen =============================================
      opts.zen = {
        enabled = false,
      }

      --============================================= dim =============================================
      opts.dim = {
        enabled = false,
      }

      --============================================= image =============================================
      opts.image = vim.tbl_deep_extend("force", opts.image or {}, {
        enabled = true,
        force = true,
        doc = {
          max_height = 20,
          max_width = 40,
          float = false,
          enabled = true,
          inline = true,
        },
        env = {
          SNACKS_GHOSTTY = true,
        },
      })

      --============================================= quickfile =============================================
      opts.quickfile = {
        enabled = false,
      }

      --============================================= toggle =============================================
      opts.toggle = {
        enabled = false,
      }

      --============================================= scroll =============================================
      opts.scroll = {
        enabled = false,
      }

      --============================================= statuscolumn =============================================
      opts.statuscolumn = {
        enabled = false,
      }

      --============================================= terminal =============================================
      opts.terminal = {
        enabled = false,
      }

      --============================================= gh =============================================
      opts.gh = {
        enabled = false,
      }

      --============================================= dashboard =============================================
      opts.dashboard = {
        enabled = false,
      }
      return opts
    end,
  },
}
