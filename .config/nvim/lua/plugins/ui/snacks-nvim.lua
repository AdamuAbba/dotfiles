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
        {
          "<leader>fE",
          function()
            Snacks.explorer({ cwd = LazyVim.root() })
          end,
          desc = "Explorer Snacks (root dir)",
        },
        {
          "<leader>fe",
          function()
            Snacks.explorer()
          end,
          desc = "Explorer Snacks (cwd)",
        },

        --============================================= find =============================================
        { "<leader>ff", LazyVim.pick("files", { layout = "select_with_preview" }), desc = "Find Files (Root Dir)" },
        {
          "<leader>fF",
          LazyVim.pick("files", { root = false, layout = "select_with_preview" }),
          desc = "Find Files (cwd)",
        },
        {
          "<leader>fc",
          LazyVim.pick("files", { root = false, layout = "select_with_preview" }),
          desc = "Find Config File",
        },
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
        --============================================= terminal =============================================
        {
          "<leader>ft",
          function()
            local current_dir = vim.fn.getcwd()
            vim.fn.jobstart({
              "zellij",
              "action",
              "new-pane",
              "--cwd",
              current_dir,
              "--floating",
              "--width=83%",
              "--height=86%",
              "--x=9%",
              "--y=10%",
            }, { detach = true })
          end,
          desc = "Terminal (Zellij Pane)",
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
      --============================================= picker =============================================
      opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, {
        layout = {
          cycle = false,
          layout = {
            backdrop = false,
          },
        },
        layouts = {
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
            win = {
              input = {
                title = "",
              },
            },
            ---@class snacks.layout.Config
            layout = {
              layout = {
                box = "vertical",
                position = "right",
                width = math.floor(vim.o.columns * 0.35),
                height = math.floor(vim.o.lines * 0.99),
                border = "rounded",
                backdrop = false,
                -- row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.92)) / 2),
                col = vim.o.columns - math.floor(vim.o.columns * 0.2),
              },
            },
          },
        },
      })
      --============================================= image =============================================
      opts.image = {
        doc = {
          max_width = 20,
          max_height = 10,
          float = false,
        },
      }
      --============================================= statuscolumn =============================================
      opts.statuscolumn = { enabled = true }
      --============================================= terminal =============================================
      opts.terminal = {
        -- for now zellij floating panes get the job done 🤔
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
                vim.cmd("edit " .. nvim_config .. "/README.md")
                vim.cmd("cd " .. nvim_config)
                require("snacks.explorer").open({
                  cwd = nvim_config,
                })
              end,
            },
            {
              icon = " ",
              key = "w",
              desc = "Edit Wezterm Config",
              action = function()
                local wezterm_config = vim.fn.expand("~/.config/wezterm")
                vim.cmd("edit " .. wezterm_config .. "/wezterm.lua")
                vim.cmd("cd " .. wezterm_config)
                require("snacks.explorer").open({
                  cwd = wezterm_config,
                })
              end,
            },
            {
              icon = "󰙏 ",
              key = "d",
              desc = "Edit diary",
              action = function()
                local obs_config = vim.fn.expand("~/Documents/shytypes-obs-vault/")
                vim.cmd("edit " .. obs_config .. "/Todo.md")
                vim.cmd("cd " .. obs_config)
                require("snacks.explorer").open({
                  cwd = obs_config,
                })
              end,
            },
            {
              icon = "󱓞 ",
              key = "s",
              desc = "Edit Starship config",
              action = function()
                local starship_config = vim.fn.expand("~/.config")
                vim.cmd("edit " .. starship_config .. "/starship.toml")
                vim.cmd("cd " .. starship_config)
                require("snacks.explorer").open({
                  cwd = starship_config,
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
    end,
  },
}
