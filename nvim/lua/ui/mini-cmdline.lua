vim.pack.add({ "https://github.com/nvim-mini/mini.cmdline" })

require("mini.cmdline").setup({
  autocomplete = {
    enable = true,
  },
  autocorrect = {
    enable = false,
  },
  autopeek = {
    enable = true,
    n_context = 1,
    window = {
      config = {
        relative = "editor",
        anchor = "NW",
        width = 40,
        border = "rounded",
      },
    },
  },
})
