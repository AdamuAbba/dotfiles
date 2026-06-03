return {
  {
    "nvim-mini/mini.diff",
    event = "VeryLazy",
    keys = {
      {
        "<leader>gdo",
        function()
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle diff overlay",
      },
    },
    opts = {
      view = {
        style = "sign",
        signs = {
          add = " ",
          change = "▎",
          delete = "",
        },
      },
    },
    config = function(_, opts)
      require("mini.diff").setup(opts)
    end,
  },
}
