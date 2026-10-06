vim.pack.add({
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/esmuellert/codediff.nvim",
})

require("codediff").setup({
  explorer = {
    width = 30,
    view_mode = "tree",
  },
  history = {
    position = "bottom",
    view_mode = "tree",
  },
  diff = {
    gutter_signs = {
      insert_text = "＋",
      delete_text = "－",
      highlight_numbers = true,
      changed_priority = 100,
    },
  },
})

vim.keymap.set("n", "<leader>gdw", "<cmd>CodeDiff HEAD~<cr>", { desc = "Diff workspace" })
vim.keymap.set("n", "<leader>gdb", "<cmd>CodeDiff file HEAD~<cr>", { desc = "Diff buffer" })
