return {
  {
    "mkindberg/ghostty-ls",
    config = function()
      vim.lsp.config.ghostty = {
        cmd = { "ghostty-ls" },
        filetypes = { "ghostty" },
      }
      vim.lsp.enable("ghostty")
    end,
  },
}
