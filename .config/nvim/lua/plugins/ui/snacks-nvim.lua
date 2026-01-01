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

        {
          "<leader>n",
          function()
            Snacks.picker.notifications({ layout = "select_with_preview" })
          end,
          desc = "Notification History",
        },
        --============================================= git =============================================
        {
          "<leader>gl",
          function()
            Snacks.picker.git_log({ layout = "select_with_preview" })
          end,
          desc = "Lazygit Log",
        },
        {
          "<leader>gd",
          function()
            Snacks.picker.git_diff({ layout = "select_with_preview" })
          end,
          desc = "Git Diff (hunks)",
        },
        {
          "<leader>gD",
          function()
            Snacks.picker.git_diff({ base = "origin", group = true, layout = "select_with_preview" })
          end,
          desc = "Git Diff (origin)",
        },
        {
          "<leader>gs",
          function()
            Snacks.picker.git_status({ layout = "select_with_preview" })
          end,
          desc = "Git Status",
        },
        {
          "<leader>gS",
          function()
            Snacks.picker.git_stash({ layout = "select_with_preview" })
          end,
          desc = "Git Stash",
        },
        --============================================= Search =============================================
        {
          "<leader>sp",
          function()
            Snacks.picker.lazy({ layout = "select_with_preview" })
          end,
          desc = "Search for Plugin Spec",
        },
        {
          "<leader>s/",
          function()
            Snacks.picker.search_history({ layout = "select_no_preview" })
          end,
          desc = "Search History",
        },
        {
          "<leader>sa",
          function()
            Snacks.picker.autocmds({ layout = "select_with_preview" })
          end,
          desc = "Autocmds",
        },
        {
          "<leader>sc",
          function()
            Snacks.picker.command_history({
              layout = "select_no_preview",
            })
          end,
          desc = "Command History",
        },
        {
          "<leader>sC",
          function()
            Snacks.picker.commands({
              layout = "select_with_preview",
            })
          end,
          desc = "Commands",
        },
        {
          "<leader>sd",
          function()
            Snacks.picker.diagnostics({ layout = "select_with_preview" })
          end,
          desc = "Diagnostics",
        },
        {
          "<leader>sD",
          function()
            Snacks.picker.diagnostics_buffer({ layout = "select_with_preview" })
          end,
          desc = "Buffer Diagnostics",
        },
        {
          "<leader>sh",
          function()
            Snacks.picker.help({ layout = "select_with_preview" })
          end,
          desc = "Help Pages",
        },
        {
          "<leader>sH",
          function()
            -- modify to copy highlight group name to primary
            -- register (the goal is to be lazy bruh 🙄)
            Snacks.picker.highlights()
          end,
          desc = "Highlights",
        },
        {
          "<leader>si",
          function()
            Snacks.picker.icons({ layout = "select_no_preview" })
          end,
          desc = "Icons",
        },
        {
          "<leader>sk",
          function()
            Snacks.picker.keymaps({ layout = "select_with_preview" })
          end,
          desc = "Keymaps",
        },
        {
          "<leader>sm",
          function()
            Snacks.picker.marks()
          end,
          desc = "Marks",
        },
        {
          "<leader>sq",
          function()
            Snacks.picker.qflist()
          end,
          desc = "Quickfix List",
        },
        --============================================= Explorer =============================================
        -- {
        --   "<leader>fE",
        --   function()
        --     Snacks.explorer({
        --       cwd = LazyVim.root(),
        --       layout = "horizontal_side_bar",
        --     })
        --   end,
        --   desc = "Explorer Snacks (root dir)",
        -- },
        -- {
        --   "<leader>fe",
        --   function()
        --     Snacks.explorer({
        --       layout = "horizontal_side_bar",
        --     })
        --   end,
        --   desc = "Explorer Snacks (cwd)",
        -- },

        --============================================= find =============================================
        { "<leader>fF", LazyVim.pick("files", { layout = "select_with_preview" }), desc = "Find Files (Root Dir)" },
        {
          "<leader>ff",
          LazyVim.pick("files", { root = false, layout = "select_with_preview" }),
          desc = "Find Files (cwd)",
        },
        {
          "<leader>fb",
          function()
            Snacks.picker.buffers({ layout = "select_with_preview" })
          end,
          desc = "Buffers",
        },
        { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
        { "<leader>fr", LazyVim.pick("oldfiles", { layout = "select_with_preview" }), desc = "Recent" },
        {
          "<leader>fp",
          function()
            Snacks.picker.projects({ dev = { "~/Documents" } })
          end,
          desc = "Projects",
        },
        --============================================= Grep =============================================
        { "<leader>fG", LazyVim.pick("grep", { layout = "select_with_preview" }), desc = "Grep (Root Dir)" },
        {
          "<leader>fg",
          LazyVim.pick("live_grep", { root = false, layout = "select_with_preview" }),
          desc = "Grep (cwd)",
        },
        {
          "<leader>sw",
          LazyVim.pick("grep_word", { layout = "select_with_preview" }),
          desc = "Visual selection or word (Root Dir)",
          mode = { "n", "x" },
        },
        {
          "<leader>sW",
          LazyVim.pick("grep_word", { root = false, layout = "select_with_preview" }),
          desc = "Visual selection or word (cwd)",
          mode = { "n", "x" },
        },
      })
    end,
    ---@param opts snacks.Config
    opts = function(_, opts)
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
      local function get_shell()
        return vim.fn.getenv("SHELL")
      end

      --============================================= indent =============================================
      opts.indent = {
        enabled = true,
        priority = 1,
        char = "╎",
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
        -- hl = {
        --     "SnacksIndent1",
        --     "SnacksIndent2",
        --     "SnacksIndent3",
        --     "SnacksIndent4",
        --     "SnacksIndent5",
        --     "SnacksIndent6",
        --     "SnacksIndent7",
        --     "SnacksIndent8",
        -- },
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
          style = "up_down",
          easing = "linear",
          duration = {
            step = 40, -- ms per step
            total = 1000, -- maximum duration
          },
        },
        ---@class snacks.indent.Scope.Config: snacks.scope.Config
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = "╎",
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
        },
        chunk = {
          -- when enabled, scopes will be rendered as chunks, except for the
          -- top-level scope which will be rendered as a scope.
          enabled = false,
          -- only show chunk scopes in the current window
          only_current = false,
          priority = 200,
          hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
          char = {
            corner_top = "┌",
            corner_bottom = "└",
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            horizontal = "─",
            vertical = "╎",
            arrow = ">",
          },
        },
        -- filter for buffers to enable indent guides
        ---@param buf number
        ---@param win number
        filter = function(buf, win)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      }

      --============================================= lazygit =============================================
      opts.lazygit = {
        enabled = true,
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
          border = "rounded",
          backdrop = false,
          title = "Lazygit",
          title_pos = "center",
        },
      }

      --============================================= explorer =============================================
      opts.explorer = {
        enabled = false,
      }
      --============================================= picker =============================================
      opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, {
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
              border = "rounded",
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
                -- title_pos = "center",
                width = 0.7,
                border = "left",
              },
            },
            -- layout = {
            --   width = math.floor(vim.o.columns * 0.60),
            --   -- row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.92)) / 2),
            --   -- col = vim.o.columns - math.floor(vim.o.columns),
            --   position = "right",
            --   backdrop = false,
            --   border = "none",
            --   box = "horizontal",
            --   {
            --     border = "rounded",
            --     win = "preview",
            --     title = "{preview}",
            --     title_pos = "center",
            --     height = 0.6,
            --   },
            --   {
            --     box = "vertical",
            --     border = "rounded",
            --     width = 0.4,
            --     {
            --       win = "input",
            --       height = 1,
            --       border = true,
            --       title = "{title} {live} {flags}",
            --       title_pos = "center",
            --     },
            --     { win = "list", border = "none" },
            --   },
            -- },
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
              border = "rounded",
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
              border = "rounded",
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
                border = "rounded",
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
                  -- title_pos = "center",
                  width = 0.7,
                  border = "left",
                },
              },
              -- layout = {
              --   width = math.floor(vim.o.columns * 0.60),
              --   -- row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.92)) / 2),
              --   -- col = vim.o.columns - math.floor(vim.o.columns),
              --   position = "right",
              --   backdrop = false,
              --   border = "none",
              --   box = "horizontal",
              --   {
              --     border = "rounded",
              --     win = "preview",
              --     title = "{preview}",
              --     title_pos = "center",
              --     height = 0.6,
              --   },
              --   {
              --     box = "vertical",
              --     border = "rounded",
              --     width = 0.4,
              --     {
              --       win = "input",
              --       height = 1,
              --       border = true,
              --       title = "{title} {live} {flags}",
              --       title_pos = "center",
              --     },
              --     { win = "list", border = "none" },
              --   },
              -- },
            },
          },
        },
      })
      --============================================= image =============================================
      opts.image = vim.tbl_deep_extend("force", opts.image or {}, {
        enabled = true,
        doc = {
          max_height = 20,
          max_width = 40,
          float = false,
          inline = true,
        },
      })
      --============================================= statuscolumn =============================================
      opts.statuscolumn = { enabled = true }

      --============================================= terminal =============================================
      opts.terminal = {
        enabled = false,
        win = {
          style = "float",
          width = math.floor(vim.o.columns * 0.7),
          height = math.floor(vim.o.lines * 0.7),
          border = "rounded",
          title = get_shell(),
          title_pos = "center",
        },
      }
      --============================================= dashboard =============================================
      opts.dashboard = {
        enabled = true,
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
                  layout = "select_with_preview",
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
                  layout = "select_with_preview",
                })
              end,
            },
            {
              icon = "󰙏 ",
              key = "d",
              desc = "Edit diary",
              action = function()
                local obs_config = vim.fn.expand("~/Documents/shytypes-obs-vault/")
                vim.cmd("cd " .. obs_config)
                Snacks.picker.files({
                  root = false,
                  layout = "select_with_preview",
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
                  layout = "select_with_preview",
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
