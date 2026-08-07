return {
  {
    "nvim-mini/mini.pick",
    version = false,
    config = function(_, opts)
      local minipick = require("mini.pick")
      local wk = require("which-key")

      opts.source = { show = minipick.default_show }
      minipick.setup(opts)

      -- Override vim.ui.select to use minipick with custom window options
      --@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(items, local_opts, on_choice)
        return minipick.ui_select(items, local_opts, on_choice, nil)
      end

      local add_items_to_qfl = function()
        local qf_items = {}
        local all_matches = minipick.get_picker_items() or {}

        for _, item in ipairs(all_matches) do
          -- Split by null byte delimiter
          local parts = vim.split(item, "\0", { plain = true })

          if #parts >= 4 then
            table.insert(qf_items, {
              filename = parts[1],
              lnum = tonumber(parts[2]) or 0,
              col = tonumber(parts[3]) or 0,
              text = parts[4],
            })
          end
        end

        if #qf_items > 0 then
          vim.fn.setqflist({}, "r", { items = qf_items, title = "Grep Results" })
          vim.cmd("copen 16")
        end

        return true
      end

      --============================================= buffer picker =============================================

      wk.add({
        {
          "<leader>fg",
          function()
            minipick.builtin.grep_live({ tool = "rg" }, {
              mappings = {
                add_all_items_to_qfl = {
                  char = "<C-q>",
                  func = add_items_to_qfl,
                },
              },
            })
          end,
          desc = "Grep (live)",
          silent = true,
          mode = { "n" },
        },
        {
          "<leader>sw",
          function()
            minipick.builtin.grep({
              pattern = vim.fn.expand("<cword>"),
              tool = "rg",
            }, {
              mappings = {
                add_all_items_to_qfl = {
                  char = "<C-q>",
                  func = add_items_to_qfl,
                },
              },
            })
          end,
          desc = "Grep visual selection",
          mode = { "n", "x" },
        },
      })
    end,
  },
}
