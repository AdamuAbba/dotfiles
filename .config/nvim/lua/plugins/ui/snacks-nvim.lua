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
          action = ":edit ~/dotfiles/.config/aerospace/aerospace.toml",
        }
      else
        return {
          icon = " ",
          key = "i",
          desc = "Edit i3 Config",
          action = ":edit ~/dotfiles/.config/i3/config",
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
          action = ":edit ~/dotfiles/.config/polybar/forest/config.ini",
        }
      end
    end
    --============================================= picker =============================================
    opts.picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          follow = true,
          layout = { layout = { position = "right" } },
        },
      },
    }
    --============================================= image =============================================
    opts.image = {}
    --============================================= statuscolumn =============================================
    opts.statuscolumn = { enabled = true }
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
            action = ":edit ~/dotfiles/.config/wezterm/wezterm.lua",
          },
          {
            icon = "󱓞 ",
            key = "s",
            desc = "Edit Starship config",
            action = ":edit ~/dotfiles/.config/starship.toml",
          },
          set_status_bar(),
          getWinManager(),
          {
            icon = "󰠓 ",
            key = "b",
            desc = "Edit Bitcoin Core Config",
            action = ":edit ~/Library/Application Support/Bitcoin/bitcoin.conf",
          },
          {
            icon = "󱐋 ",
            key = "l",
            desc = "Edit Lightening Config",
            action = ":edit ~/Library/Application Support/Lnd/lnd.conf",
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
