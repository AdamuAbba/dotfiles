return {
  {
    "nvim-mini/mini.pick",
    dependencies = {
      {
        "nvim-mini/mini.bufremove",
        version = false,
      },
    },
    version = false,
    config = function(_, opts)
      local MiniPick = require("mini.pick")
      local bufremove = require("mini.bufremove")
      local wk = require("which-key")
      local icons = require("lib.icons")

      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)

      opts.source = { show = MiniPick.default_show }
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

      -- Override vim.ui.select to use MiniPick with custom window options
      vim.ui.select = function(items, local_opts, on_choice)
        return MiniPick.ui_select(items, local_opts, on_choice, nil)
      end

      MiniPick.setup(opts)

      local add_items_to_qfl = function(items)
        local qf_items = {}

        for _, item in ipairs(items) do
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

        vim.notify("+" .. #qf_items .. " quickfix list")
        if #qf_items > 0 then
          vim.fn.setqflist({}, "r", { items = qf_items, title = "Grep Results" })
        end

        return false
      end

      --============================================= buffer picker =============================================
      local function handle_buffer()
        local wipeout_cur = function()
          local exclude_map = {}
          local matches = MiniPick.get_picker_matches()

          if vim.tbl_count(matches.marked) > 0 then
            for _, mark in pairs(matches.marked) do
              if mark == nil then
                return
              end
              exclude_map[mark.bufnr] = true
              bufremove.delete(mark.bufnr)
            end
          elseif matches and matches.current and matches.current.bufnr then
            exclude_map[matches.current.bufnr] = true
            bufremove.delete(matches.current.bufnr)
          end

          local filter = vim.tbl_filter(function(value)
            return not exclude_map[value.bufnr]
          end, MiniPick.get_picker_items())
          MiniPick.set_picker_items(filter)
        end

        local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } }
        MiniPick.builtin.buffers(_, { mappings = buffer_mappings })
      end

      wk.add({
        {
          "<leader>fb",
          handle_buffer,
          desc = "Pick buffer",
          silent = true,
          mode = { "n" },
        },
        {
          "<leader>ff",
          function()
            MiniPick.builtin.files({ tool = "rg" })
          end,
          desc = "Find Files",
          silent = true,
          mode = { "n" },
        },
        {
          "<leader>fg",
          function()
            MiniPick.builtin.grep_live({ tool = "rg" }, {
              source = {
                choose_marked = add_items_to_qfl,
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
            MiniPick.builtin.grep({
              pattern = vim.fn.expand("<cword>"),
              tool = "rg",
            })
          end,
          desc = "Grep visual selection",
          mode = { "n", "x" },
        },
      })
    end,
  },
}
