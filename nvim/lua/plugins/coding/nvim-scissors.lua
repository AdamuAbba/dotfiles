return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = function(_, opts)
      local icons = require("lib.icons")

      opts.jsonFormatOpts = vim.tbl_deep_extend("force", opts.jsonFormatOpts or {}, {
        sort_keys = true,
        indent = "  ",
      })
      opts.backdrop = vim.tbl_deep_extend("force", opts.backdrop or {}, {
        enabled = false,
        blend = 50,
      })
      opts.editSnippetPopup = vim.tbl_deep_extend("force", opts.editSnippetPopup or {}, {
        border = icons.custom_border,
      })
      opts.snippetSelection = vim.tbl_deep_extend("force", opts.snippetSelection or {}, {
        picker = "vim.ui.select", ---@type "auto"|"fzf-lua"|"telescope"|"snacks"|"vim.ui.select"
      })
      return opts
    end,
    config = function(_, opts)
      local Scissors = require("scissors")
      local wk = require("which-key")

      wk.add({
        { "<leader>h", group = "scissors", mode = { "n", "x" } },
        {
          "<leader>he",
          function()
            Scissors.editSnippet()
          end,
          desc = "Edit snippet",
        },
        {
          "<leader>ha",
          function()
            Scissors.addNewSnippet()
          end,
          desc = "Add new snippet",
          mode = { "n", "x" },
        },
      })

      Scissors.setup(opts)
    end,
  },
}
