local theme_colors = require("config/theme-colors")

return {
  {
    "vuki656/package-info.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      highlights = {
        up_to_date = {
          fg = theme_colors.green,
        },
        outdated = {
          fg = theme_colors.orange,
        },
        invalid = {
          fg = theme_colors.red,
        },
      },
      icons = {
        enable = true,
        style = {
          up_to_date = "|  ",
          outdated = "|  ",
          invalid = "|  ",
        },
      },
      notifications = false,
      autostart = true,
      hide_up_to_date = false,
      hide_unstable_versions = false,
      package_manager = "yarn",
    },
  },
}
