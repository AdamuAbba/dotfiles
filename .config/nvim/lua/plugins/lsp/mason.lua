return {
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ui = vim.tbl_deep_extend("force", opts.ui or {}, {
        border = "rounded",
        backdrop = 100,
      })
      vim.list_extend(opts.ensure_installed or {}, { "codelldb" })
      ---@diagnostic disable-next-line: undefined-global
      if diagnostics == "bacon-ls" then
        vim.list_extend(opts.ensure_installed, { "bacon" })
      end
    end,
  },
}
