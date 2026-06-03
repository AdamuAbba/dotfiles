return {
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    cmd = { "TodoTelescope" },
    keys = function()
      return {
        { "<leader>st", "<cmd>TodoTelescope keywords=TODO<cr>", desc = "Todo" },
      }
    end,
  },
}
