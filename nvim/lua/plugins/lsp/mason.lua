return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ui = vim.tbl_deep_extend("force", opts.ui or {}, {
        border = "rounded",
        backdrop = 100,
      })
      opts.registries = {
        "github:mason-org/mason-registry",
        "github:mkindberg/ghostty-ls",
      }
      vim.list_extend(opts.ensure_installed, {
        "harper-ls",
        "just-lsp",
        "graphql-language-service-cli",
        "gitlint",
        "stylelint",
        "lemminx",
        "html-lsp",
        "css-lsp",
        "htmlhint",
        "tombi",
        "markdownlint-cli2",
        "markdown-toc",
        "nil",
        "statix",
      })
      return opts
    end,
  },
}
