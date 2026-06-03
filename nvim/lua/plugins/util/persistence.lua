return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>qS",
        false,
      },
      {
        "<leader>ql",
        false,
      },
      {
        "<leader>qd",
        false,
      },
    },
  },
}
