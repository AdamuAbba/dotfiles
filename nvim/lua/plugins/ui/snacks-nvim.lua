---@diagnostic disable: undefined-field, undefined-global
return {
  {
    "folke/snacks.nvim",
    keys = function(_, keys)
      vim.list_extend(keys, {
        { "<leader>,", false },
        { "<leader>:", false },
        { "<leader>/", false },
        { "<leader>e", false },
        { "<leader>E", false },
        { '<leader>s"', false },
        { "<leader><space>", false },
        { "<leader>sg", false },
        { "<leader>sG", false },
        { "<leader>sa", false },
        { "<leader>sj", false },
        { "<leader>sR", false },
        { "<leader>sl", false },
        { "<leader>uC", false },
        { "<leader>fB", false },
        { "<leader>fR", false },
        { "<leader>fT", false },
        { "<leader>sb", false },
        { "<leader>sB", false },
        { "<leader>su", false },
        { "<leader>sM", false },
        { "<leader>fe", false },
        { "<leader>fE", false },
        -------- search
        { "<leader>sk", false },
        { "<leader>sm", false },
        { "<leader>sC", false },
        { "<leader>sc", false },
        { "<leader>sa", false },
        { "<leader>s/", false },
        { "<leader>sq", false },
        -------- find
        { "<leader>fb", false },
        { "<leader>ff", false },
        { "<leader>fF", false },
        { "<leader>fh", false },
        { "<leader>fr", false },
        { "<leader>fc", false },
        { "<leader>fp", false },
        -------- grep
        { "<leader>fg", false },
        { "<leader>sw", false },
        { "<leader>sW", false },
        -------- terminal
        { "<leader>ft", false },
        { "<leader>fT", false },
        { "<c-/>", false },
        { "<c-_>", false },
        -------- search
        { "<leader>sh", false },
        { "<leader>sH", false },
        { "<leader>sp", false },
        -------- git
        { "<leader>gi", false },
        { "<leader>gI", false },
        { "<leader>go", false },
        { "<leader>gd", false },
        { "<leader>gD", false },
        { "<leader>gs", false },
        { "<leader>gS", false },
        { "<leader>gb", false },
        { "<leader>gB", false },
        { "<leader>gf", false },
        { "<leader>gl", false },
        { "<leader>gL", false },
        { "<leader>gY", false },
        { "<leader>gy", false },
        { "<leader>gp", false },
        { "<leader>gP", false },
        -------- diagnostics
        { "<leader>sd", false },
        { "<leader>sD", false },
        ---------- lsp (disable Snacks lsp bindings here also just incase)
        { "gd", false },
        { "gD", false },
        { "gr", false },
        { "gI", false },
        { "gy", false },
        { "<leader>ss", false },
        { "<leader>sS", false },

        --============================================= Notification =============================================
        {
          "<leader>n",
          function()
            Snacks.notifier.show_history()
          end,
          desc = "Notification History",
        },
        {
          "<leader>si",
          function()
            Snacks.picker.icons({ layout = "select_no_preview" })
          end,
          desc = "Icons",
        },
      })
    end,
    ---@param opts snacks.Config
    opts = function(_, opts)
      local custom_border = require("lib..icons").custom_border

      ---@type table<string, snacks.win.Config>
      opts.styles = vim.tbl_deep_extend("force", opts.styles or {}, {
        notification = {
          border = custom_border,
          zindex = 100,
          ft = "markdown",
          wo = {
            winblend = 0,
            wrap = false,
            conceallevel = 2,
            colorcolumn = "",
          },
          bo = { filetype = "snacks_notif" },
        },
        notification_history = {
          border = custom_border,
          zindex = 100,
          width = 0.7,
          height = 0.7,
          minimal = false,
          title = " Notification History ",
          title_pos = "left",
          ft = "markdown",
          bo = { filetype = "snacks_notif_history", modifiable = false },
          wo = { winhighlight = "Normal:SnacksNotifierHistory" },
          keys = {
            q = "close",
            ["<Esc>"] = "close",
          },
        },
      })

      local function getWinManager()
        if vim.fn.has("mac") == 1 then
          return {
            icon = " ",
            key = "a",
            desc = "Edit Aerospace Config",
            action = ":edit $HOME/.config/aerospace/aerospace.toml",
          }
        else
          return {
            icon = " ",
            key = "i",
            desc = "Edit i3 Config",
            action = ":edit $HOME/.config/i3/config",
          }
        end
      end
      local function set_status_bar()
        if vim.fn.has("mac") == 1 then
          return {}
        else
          return {
            icon = " ",
            key = "p",
            desc = "Edit Polybar Config",
            action = ":edit $HOME/.config/polybar/forest/config.ini",
          }
        end
      end

      --============================================= gitbrowse =============================================
      opts.gitbrowse = {
        enabled = false,
      }
      --============================================= bigfile =============================================
      opts.bigfile = vim.tbl_deep_extend("force", opts.bigfile or {}, {
        enabled = true,
      })
      --============================================= animate =============================================
      opts.animate = vim.tbl_deep_extend("force", opts.animate or {}, {
        enabled = true,
      })

      --============================================= input =============================================
      opts.input = vim.tbl_deep_extend("force", opts.input or {}, {
        enabled = true,
      })

      --============================================= scope =============================================
      opts.scope = vim.tbl_deep_extend("force", opts.scope or {}, {
        enabled = true,
      })

      --============================================= notifier =============================================
      opts.notifier = vim.tbl_deep_extend("force", opts.notifier or {}, {
        enabled = true,
      })

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
      opts.lazygit = vim.tbl_deep_extend("force", opts.lazygit or {}, {
        enabled = false,
        theme = {
          [241] = { fg = "Special" },
          activeBorderColor = { fg = "@keyword", bold = true },
          inactiveBorderColor = { fg = "DiagnosticFloatingHint", bold = true },
          cherryPickedCommitBgColor = { fg = "Identifier" },
          cherryPickedCommitFgColor = { fg = "Function" },
          defaultFgColor = { fg = "Normal" },
          optionsTextColor = { fg = "Function" },
          searchingActiveBorderColor = { fg = "MatchParen", bold = true },
          selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
          unstagedChangesColor = { fg = "DiagnosticError" },
        },
        win = {
          style = "lazygit",
          width = math.floor(vim.o.columns * 0.94),
          height = math.floor(vim.o.lines * 0.92),
          row = math.floor(vim.o.lines * 0.03),
          col = math.floor(vim.o.columns * 0.03),
          border = custom_border,
          backdrop = false,
          title = "Lazygit",
          title_pos = "center",
        },
      })

      --============================================= explorer =============================================
      opts.explorer = {
        enabled = false,
      }
      --============================================= picker =============================================
      opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, {
        hidden = true,
        layout = {
          cycle = false,
          layout = {
            backdrop = false,
          },
        },
        layouts = {
          horizontal_side_bar = {
            preview = true,
            layout = {
              box = "horizontal",
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.5,
              border = custom_border,
              title = "",
              title_pos = "left",
              {
                box = "vertical",
                { win = "input", height = 1, border = custom_border },
                { win = "list", border = "none" },
              },
              {
                win = "preview",
                title = "{preview}",
                -- title_pos = "center",
                width = 0.7,
                border = "left",
              },
            },
          },
          select_no_preview = {
            preview = false,
            layout = {
              width = 0.5,
              height = 0.4,
              backdrop = false,
              min_width = 80,
              min_height = 3,
              box = "vertical",
              border = custom_border,
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
          select_with_preview = {
            preview = true,
            layout = {
              backdrop = false,
              width = math.floor(vim.o.columns * 0.90),
              height = math.floor(vim.o.lines * 0.90),
              row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.90)) / 2) - 3,
              col = math.floor((vim.o.columns - math.floor(vim.o.columns * 0.90)) / 2),
              min_width = 80,
              min_height = 3,
              box = "vertical",
              border = custom_border,
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.7, border = "top" },
            },
          },
        },
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            follow = true,
            follow_file = true,
            trash = true,
            win = {
              input = {
                title = "Explorer",
              },
            },
            ---@class snacks.layout.Config
            layout = {
              preview = true,
              layout = {
                box = "horizontal",
                backdrop = false,
                row = -1,
                width = 0,
                height = 0.5,
                border = custom_border,
                title = "",
                title_pos = "left",
                {
                  box = "vertical",
                  { win = "input", height = 1, border = "rounded" },
                  { win = "list", border = "none" },
                },
                {
                  win = "preview",
                  title = "{preview}",
                  width = 0.7,
                  border = "left",
                },
              },
            },
          },
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
      opts.quickfile = vim.tbl_deep_extend("force", opts.quickfile or {}, {
        enabled = true,
      })

      --============================================= toggle =============================================
      opts.toggle = {
        enabled = false,
      }

      --============================================= scroll =============================================
      opts.scroll = vim.tbl_deep_extend("force", opts.scroll or {}, {
        enabled = true,
      })

      --============================================= statuscolumn =============================================
      opts.statuscolumn = vim.tbl_deep_extend("force", opts.statuscolumn or {}, {
        enabled = true,
        left = {},
        right = { "sign", "fold" },
        folds = {
          open = true,
          git_hl = true,
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50,
      })

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
        width = 60,
        row = nil,
        col = nil,
        sections = {
          { section = "header" },
          { section = "keys", gap = 0.5, padding = 1 },
        },
        ---@class snacks.dashboard.Config
        preset = {
          pick = nil,
          header = [[
       ███████╗██╗  ██╗██╗   ██╗████████╗██╗   ██╗██████╗ ███████╗███████╗
       ██╔════╝██║  ██║╚██╗ ██╔╝╚══██╔══╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔════╝
       ███████╗███████║ ╚████╔╝    ██║    ╚████╔╝ ██████╔╝█████╗  ███████╗
       ╚════██║██╔══██║  ╚██╔╝     ██║     ╚██╔╝  ██╔═══╝ ██╔══╝  ╚════██║
       ███████║██║  ██║   ██║      ██║      ██║   ██║     ███████╗███████║
       ╚══════╝╚═╝  ╚═╝   ╚═╝      ╚═╝      ╚═╝   ╚═╝     ╚══════╝╚══════╝
        ]],
          keys = {
            {
              icon = "󰘿 ",
              key = "u",
              desc = "Update Plugins",
              action = ":Lazy update",
            },
            {
              icon = " ",
              key = "p",
              desc = "Projects",
              action = function()
                Snacks.picker.projects({ dev = { "~/Documents" } })
              end,
            },
            {
              icon = " ",
              key = "n",
              desc = "Edit Nvim Config",
              action = function()
                local nvim_config = vim.fn.expand("~/.config/nvim")
                vim.cmd("cd " .. nvim_config)
                Snacks.picker.files({
                  root = false,
                })
              end,
            },
            {
              icon = " ",
              key = "w",
              desc = "Edit Wezterm Config",
              action = function()
                local wezterm_config = vim.fn.expand("~/.config/wezterm")
                vim.cmd("cd " .. wezterm_config)
                Snacks.picker.files({
                  root = false,
                })
              end,
            },
            {
              icon = "󱓞 ",
              key = "s",
              desc = "Edit Starship config",
              action = function()
                local starship_config = vim.fn.expand("~/.config")
                vim.cmd("cd " .. starship_config)
                Snacks.picker.files({
                  root = false,
                })
              end,
            },
            set_status_bar(),
            getWinManager(),
            {
              icon = "󰠓 ",
              key = "b",
              desc = "Edit Bitcoin Core Config",
              action = ":edit $HOME/Library/Application Support/Bitcoin/bitcoin.conf",
            },
            {
              icon = "󱐋 ",
              key = "l",
              desc = "Edit Lightening Config",
              action = ":edit $HOME/Library/Application Support/Lnd/lnd.conf",
            },
            { icon = " ", key = "z", desc = "Edit .zshrc", action = ":edit ~/.zshrc" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          formats = {
            icon = function(item)
              if item.file and item.icon == "file" or item.icon == "directory" then
                return M.icon(item.file, item.icon)
              end
              return { item.icon, width = 2, hl = "icon" }
            end,
            key = function(item)
              return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
            end,
            footer = { "%s", align = "center" },
            header = { "%s", align = "center" },
            file = function(item, ctx)
              local fname = vim.fn.fnamemodify(item.file, ":~")
              fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
              local dir, file = fname:match("^(.*)/(.+)$")
              return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
            end,
          },
        },
      }
      return opts
    end,
  },
}
