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
        "rust-analyzer",
      })
      return opts
    end,
  },
}
