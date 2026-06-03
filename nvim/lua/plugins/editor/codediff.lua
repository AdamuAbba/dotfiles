return {
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    keys = {
      { "<leader>gdw", "<cmd>CodeDiff HEAD~<cr>", desc = "Diff workspace" },
      { "<leader>gdb", "<cmd>CodeDiff file HEAD~<cr>", desc = "Diff buffer" },
    },
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
