return {
  {
    "nvim-mini/mini.extra",
    version = false,
    config = function(_, opts)
      local MiniExtra = require("mini.extra")
      local wk = require("which-key")
      local icons = require("lib.icons")

      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)

      opts.window = {
        config = {
          border = icons.custom_border,
          relative = "editor",
          anchor = "NW",
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        },
      }

      MiniExtra.setup(opts)

      local copy_item_continue = function(item)
        if type(item) == "string" then
          vim.fn.setreg("+", item)
          vim.notify("+1 clipboard")
          return false
        end
        local lines = {}
        for _, it in ipairs(item) do
          table.insert(lines, it)
        end
        vim.fn.setreg("+", table.concat(lines, "\n"))
        vim.notify("+" .. #lines .. " clipboard")
        return false
      end

      wk.add({
        {
          "<leader>fr",
          function()
            MiniExtra.pickers.visit_paths()
          end,
          desc = "Visit Recent paths",
        },
        {
          "<leader>sd",
          function()
            MiniExtra.pickers.diagnostic({ scope = "current" })
          end,
          desc = "Buffer Diagnostics",
        },
        {
          "<leader>sD",
          function()
            MiniExtra.pickers.diagnostic({ scope = "all" })
          end,
          desc = "Workspace Diagnostics",
        },
        {
          "<leader>sk",
          function()
            MiniExtra.pickers.keymaps()
          end,
          desc = "Keymaps",
        },
        {
          "<leader>sH",
          function()
            MiniExtra.pickers.hl_groups(_, {
              source = {
                choose = copy_item_continue,
                choose_marked = copy_item_continue,
              },
            })
          end,
          desc = "Highlight Groups",
        },
        {
          "<leader>sc",
          function()
            MiniExtra.pickers.history({ scope = ":" })
          end,
          desc = "Command History",
        },
        {
          "<leader>sq",
          function()
            MiniExtra.pickers.list({ scope = "quickfix" })
          end,
          desc = "Command History",
        },
        {
          "<leader>s/",
          function()
            MiniExtra.pickers.history({ scope = "/" })
          end,
          desc = "search History",
        },
      })
    end,
  },
}
