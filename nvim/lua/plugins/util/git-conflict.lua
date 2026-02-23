return {
  {
    "akinsho/git-conflict.nvim",
    version = false,
    event = "BufReadPre",
    dependencies = {
      "folke/which-key.nvim",
      "nvim-mini/mini.extra",
    },
    opts = function(_, opts)
      local MiniExtra = require("mini.extra")

      opts.default_mappings = false
      opts.disable_diagnostics = true
      opts.list_opener = function()
        MiniExtra.pickers.list({ scope = "quickfix" })
      end
      return opts
    end,
    config = function(_, opts)
      require("git-conflict").setup(opts)
      local wk = require("which-key")
      wk.add({
        { "<leader>gc", group = "+git conflict", mode = { "n" } },
        { "<leader>gcc", "<Plug>(git-conflict-ours)", desc = "Current changes" },
        { "<leader>gci", "<Plug>(git-conflict-theirs)", desc = "Incoming changes" },
        { "<leader>gcb", "<Plug>(git-conflict-both)", desc = "Both changes" },
        { "<leader>gcn", "<Plug>(git-conflict-none)", desc = "None" },
        { "]c", "<Plug>(git-conflict-next-conflict)", desc = "Next Conflict" },
        { "[c", "<Plug>(git-conflict-prev-conflict)", desc = "Previous Conflict" },
        { "<leader>gcq", "<cmd>GitConflictListQf<cr>", desc = "Conflicts to Quickfix" },
      })
    end,
  },
}
