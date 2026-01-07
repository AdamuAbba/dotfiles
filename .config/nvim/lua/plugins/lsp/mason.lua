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
      return opts
    end,
  },
}
