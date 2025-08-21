---@diagnostic disable: undefined-field, undefined-global
return {
  "folke/snacks.nvim",
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
    opts.picker = {
      layout = {
        layout = {
          backdrop = false,
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
          layout = {
            layout = {
              box = "vertical",
              position = "float",
              width = math.floor(vim.o.columns * 0.35),
              height = math.floor(vim.o.lines * 0.93),
              border = "rounded",
              backdrop = false,
              row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.92)) / 2) - 4, -- move 3 lines up
              col = vim.o.columns - math.floor(vim.o.columns * 0.2), --
            },
          },
        },
      },
    }
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
      enabled = true,
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
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      sections = {
        { section = "header" },
        { section = "keys", gap = 0.5, padding = 1 },
        { icon = " ", title = "Projects", gap = 0.5, section = "projects", indent = 2, padding = 1 },
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
            icon = " ",
            key = "n",
            desc = "Edit Nvim Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = " ",
            key = "w",
            desc = "Edit Wezterm Config",
            action = ":edit $HOME/.config/wezterm/wezterm.lua",
          },
          {
            icon = "󰙏 ",
            key = "d",
            desc = "Edit diary",
            action = ":edit $HOME/Documents/shytypes-obs-vault/Todo.md",
          },
          {
            icon = "󱓞 ",
            key = "s",
            desc = "Edit Starship config",
            action = ":edit $HOME/.config/starship.toml",
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
}
