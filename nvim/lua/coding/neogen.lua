vim.pack.add({ "https://github.com/danymat/neogen" })

require("neogen").setup({
  snippet_engine = "nvim",
  enabled = true,
  input_after_comment = true,
})
