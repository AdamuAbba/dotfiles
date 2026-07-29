return {
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function(_, opts)
      opts.popup = vim.tbl_deep_extend("force", opts.popup or {}, {
        style = "minimal",
        border = "rounded",
        show_version_date = true,
      })
      require("crates").setup(opts)
    end,
  },
}
