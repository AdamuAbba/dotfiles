return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local custom_border = require("lib.icons").custom_border

      opts.ui = vim.tbl_deep_extend("force", opts.ui or {}, {
        border = custom_border,
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
        "rust-analyzer",
        "gitlint",
        "stylelint",
        "lemminx",
        "html-lsp",
        "css-lsp",
        "htmlhint",
        "selene",
        "tombi",
        "tsgo",
        "markdownlint-cli2",
        "markdown-toc",
      })
      return opts
    end,
  },
}
