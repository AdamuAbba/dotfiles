return {
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = function(_, opts)
      local go_to_preview = require("goto-preview")
      local wk = require("which-key")
      local icons = require("lib.icons")

      opts.references = {
        provider = "mini_pick",
      }
      opts.border = icons.custom_border
      opts.focus_on_open = true
      opts.preview_window_title = {
        enable = true,
        position = "center",
      }
      opts.post_open_hook = function(buf, win)
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf, desc = "Close Preview" })
      end

      wk.add({
        { "gb", group = "Goto Preview", icon = " ", mode = { "n" } },
        {
          "gbi",
          function()
            go_to_preview.goto_preview_implementation({ focus_on_open = true })
          end,
          icon = "",
          desc = "Preview Implementation",
        },
        {
          "gbr",
          function()
            go_to_preview.goto_preview_references()
          end,
          icon = "",
          desc = "Preview References",
        },
        {
          "gbD",
          function()
            go_to_preview.goto_preview_declaration({ focus_on_open = true })
          end,
          icon = "",
          desc = "Preview Declaration",
        },
        {
          "gbd",
          function()
            go_to_preview.goto_preview_definition()
          end,
          icon = "",
          desc = "Preview Definition",
        },
        {
          "gbt",
          function()
            go_to_preview.goto_preview_type_definition({})
          end,
          icon = "󰙅",
          desc = "Preview Type Definition",
        },
      })

      go_to_preview.setup(opts)
    end,
  },
}
