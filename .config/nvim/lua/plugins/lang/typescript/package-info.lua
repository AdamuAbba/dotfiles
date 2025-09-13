local theme_colors = require("config/theme-colors")

return {
  {
    "vuki656/package-info.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      colors = {
        up_to_date = theme_colors.green,
        outdated = theme_colors.orange,
        invalid = theme_colors.red,
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
      -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one, if nothing is provided it will use `yarn`
      package_manager = "yarn",
    },
  },
}
