return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "python",
        "node2",
        "chrome",
        "js",
      })
    end,
  },
}
