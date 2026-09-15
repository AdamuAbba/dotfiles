return {
  {
    "esmuellert/codediff.nvim",
    lazy = false,
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
      opts.diff = vim.tbl_deep_extend("force", opts.diff or {}, {
        gutter_signs = {
          insert_text = "＋",
          delete_text = "－",
          highlight_numbers = true,
          changed_priority = 100,
          unchanged_priority = nil,
        },
      })
      return opts
    end,
  },
}
