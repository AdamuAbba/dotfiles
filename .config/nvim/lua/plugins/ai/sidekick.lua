return {
  {
    "folke/sidekick.nvim",
    opts = function(_, opts)
      opts.cli = vim.tbl_deep_extend("force", opts.cli or {}, {
        mux = {
          enabled = true,
          backend = "tmux",
        },
      })
    end,
    keys = {
      {
        "<leader>ag",
        function()
          require("sidekick.cli").toggle({ name = "gemini", focus = true })
        end,
        desc = "Sidekick Toggle Gemini",
      },
    },
  },
}
