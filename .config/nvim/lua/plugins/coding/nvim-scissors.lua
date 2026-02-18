return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = function(_, opts)
      local icons = require("lib.icons")

      ---@type "yq"|"jq"|"none"|string[]
      opts.jsonFormatter = "jq"
      opts.editSnippetPopup = {
        border = icons.custom_border,
      }
      opts.backdrop = vim.tbl_deep_extend("force", opts.backdrop or {}, {
        enabled = false,
        blend = 0,
      })
      return opts
    end,
    config = function(_, opts)
      local Scissors = require("scissors")
      local wk = require("which-key")
      local icons = require("lib.icons")

      wk.add({
        { "<leader>h", group = "scissors", icon = icons.ui.Scissors, mode = { "n" } },
        {
          "<leader>he",
          function()
            Scissors.editSnippet()
          end,
          desc = "Edit snippet",
          icon = icons.ui.Edit,
        },
        {
          "<leader>ha",
          function()
            Scissors.addNewSnippet()
          end,
          desc = "Add new snippet",
          icon = icons.ui.AddAlt,
          mode = { "n", "x" },
        },
      })

      Scissors.setup(opts)
    end,
  },
}
