return {
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    opts = function(_, opts)
      opts.explorer = vim.tbl_deep_extend("force", opts.explorer or {}, {
        width = 30,
        view_mode = "tree",
      })
      opts.history = vim.tbl_deep_extend("force", opts.history or {}, {
          position = "bottom",
          view_mode = "tree",
        })
      return opts
    end,
  },
}
