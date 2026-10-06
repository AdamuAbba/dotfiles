vim.pack.add({ "https://github.com/max397574/better-escape.nvim" })

require("better_escape").setup({
  timeout = vim.o.timeoutlen,
  default_mappings = false,
  mappings = {
    i = {
      j = {
        j = "<Esc>",
      },
    },
    t = {
      ["<ESC>"] = {
        ["<ESC>"] = "<C-\\><C-n>",
      },
    },
  },
})
