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
    --============================================= picker =============================================
    opts.picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          follow = true,
          layout = {
            layout = {
              position = "float",
              width = math.floor(vim.o.columns * 0.6),
              height = math.floor(vim.o.lines * 0.8),
              border = "rounded",
              backdrop = true,
            },
          },
        },
      },
    }
    opts.styles = {}
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
      ---@class snacks.dashboard.Config
      preset = {
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "Keep cooking 🔥" .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          }
        end,
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
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
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
        sections = {
          { section = "header" },
          { section = "keys" },
          { section = "startup" },
        },
      },
    }
    return opts
  end,
}
