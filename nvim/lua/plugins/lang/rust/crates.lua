return {
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function(_, opts)
      local custom_border = require("lib.icons").custom_border
      opts.popup = vim.tbl_deep_extend("force", opts.popup or {}, {
        style = "minimal",
        border = custom_border,
        show_version_date = true,
      })
      require("crates").setup(opts)
    end,
  },
}
