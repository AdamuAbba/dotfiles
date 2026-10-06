vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

require("grug-far").setup({ headerMaxWidth = 80 })

vim.keymap.set({ "n", "v" }, "<leader>sr", function()
  require("grug-far").with_visual_selection({
    transient = true,
    prefills = { paths = vim.fn.expand("%") },
  })
end, { desc = "Search and Replace" })
