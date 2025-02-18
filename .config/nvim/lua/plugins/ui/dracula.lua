return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    opts = {
      lualine_bg_color = "#282A36",
      italic_comment = true,
    },
    config = function(_, opts)
      require("dracula").setup(opts)
    end,
  },
}
