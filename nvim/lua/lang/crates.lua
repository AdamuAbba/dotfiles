vim.pack.add({ { src = "https://github.com/saecki/crates.nvim", version = "stable" } })

require("crates").setup({
  popup = {
    style = "minimal",
    border = "rounded",
    show_version_date = true,
  },
})
