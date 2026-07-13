return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    enabled = false,
    keys = function()
      return {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash",
        },
      }
    end,
    opts = function()
      return {
        modes = {
          search = {
            enabled = false,
          },
        },
      }
    end,
  },
}
