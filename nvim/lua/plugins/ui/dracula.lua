local theme_colors = require("config.theme-colors")

return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    opts = {
      colors = {
        bg = theme_colors.background,
      },
      italic_comment = true,
      lualine_bg_color = theme_colors.background,
      overrides = function(_)
        local highlight_overrides = require("lib.highlight-overrides")
        return highlight_overrides.groups
      end
    },
    config = function(_, opts)
      require("dracula").setup(opts)
    end,
  },
}
