return {
  {
    "nvim-mini/mini.extra",
    version = false,
    config = function(_, opts)
      local MiniExtra = require("mini.extra")
      local wk = require("which-key")

      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)

      opts.window = {
        config = {
          border = "rounded",
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
      })
    end,
  },
}
