vim.pack.add({ "https://github.com/chrisgrieser/nvim-scissors" })

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

Scissors.setup({
  jsonFormatOpts = { sort_keys = true, indent = "  " },
  backdrop = { enabled = false, blend = 50 },
  editSnippetPopup = { border = "rounded" },
  snippetSelection = { picker = "vim.ui.select" },
})
