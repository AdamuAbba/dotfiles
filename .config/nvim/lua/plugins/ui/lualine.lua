return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local theme_colors = require("config/theme-colors")
      local icons = LazyVim.config.icons

      local custom_dracula_theme = {
        normal = {
          a = { fg = theme_colors.black, bg = theme_colors.purple, gui = "bold" },
          b = { fg = theme_colors.white, bg = theme_colors.selection, gui = "bold" },
          c = { bg = theme_colors.black, gui = "bold" },
          z = { fg = theme_colors.black, bg = theme_colors.purple, gui = "bold" },
        },
        insert = {
          a = { fg = theme_colors.black, bg = theme_colors.green, gui = "bold" },
          b = { fg = theme_colors.white, bg = theme_colors.selection, gui = "bold" },
          c = { bg = theme_colors.black, gui = "bold" },
          z = { fg = theme_colors.black, bg = theme_colors.green, gui = "bold" },
        },
        visual = {
          a = { fg = theme_colors.black, bg = theme_colors.pink, gui = "bold" },
          b = { fg = theme_colors.white, bg = theme_colors.selection, gui = "bold" },
          c = { bg = theme_colors.black, gui = "bold" },
          z = { fg = theme_colors.black, bg = theme_colors.pink, gui = "bold" },
        },
        command = {
          a = { fg = theme_colors.black, bg = theme_colors.orange, gui = "bold" },
          b = { fg = theme_colors.white, bg = theme_colors.selection, gui = "bold" },
          c = { bg = theme_colors.black, gui = "bold" },
          z = { fg = theme_colors.black, bg = theme_colors.orange, gui = "bold" },
        },
        replace = {
          a = { fg = theme_colors.black, bg = theme_colors.yellow },
          b = { fg = theme_colors.white, bg = theme_colors.selection, gui = "bold" },
          c = { bg = theme_colors.black, gui = "bold" },
          z = { fg = theme_colors.black, bg = theme_colors.yellow, gui = "bold" },
        },
        inactive = {
          a = { fg = theme_colors.white, bg = theme_colors.selection },
          b = { bg = theme_colors.selection },
          c = { bg = theme_colors.black },
          z = { bg = theme_colors.black },
        },
      }
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        theme = custom_dracula_theme,
        component_separators = "",
        section_separators = "",
      })
      opts.sections = vim.tbl_deep_extend("force", opts.sections or {}, {
        lualine_a = {
          { "mode", separator = { left = "", right = "" } },
        },
        lualine_b = {
          { "branch" },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = false, colored = true },
          { LazyVim.lualine.pretty_path(), separator = { right = "" } },
        },
        lualine_c = {},
        lualine_y = {},
        lualine_z = {
          {
            "lsp_status",
            icon = "󰘿 ",
            symbols = {
              spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              done = "✓",
              separator = ", ",
            },
            color = { fg = theme_colors.black, gui = "bold" },
            ignore_lsp = {},
            show_name = true,
            separator = { left = "", right = "" },
          },
        },
      })
      return opts
    end,
  },
}
