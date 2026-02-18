return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local theme_colors = require("config/theme-colors")
      local icons = LazyVim.config.icons

      local custom_dracula_theme = {
        normal = {
          a = { fg = theme_colors.white, bg = theme_colors.gray, bold = true },
          b = { fg = theme_colors.white, bg = theme_colors.gray, bold = true },
          c = { bg = theme_colors.black },
          x = { fg = theme_colors.white, bg = theme_colors.gray, bold = true },
          y = { fg = theme_colors.white, bg = theme_colors.gray, bold = true },
          z = { fg = theme_colors.white, bg = theme_colors.gray, bold = true },
        },
        insert = {
          a = { fg = theme_colors.white, bg = "#58514E", bold = true, gui = "bold" },
          b = { fg = theme_colors.white, bg = theme_colors.gray, bold = true },
          c = { bg = theme_colors.black, bold = true },
          x = { fg = theme_colors.white, bg = theme_colors.gray, bold = true },
          y = { fg = theme_colors.white, bg = "#58514E", bold = true },
          z = { fg = theme_colors.white, bg = "#58514E", bold = true },
        },
        visual = {
          a = { fg = theme_colors.black, bg = theme_colors.pink, gui = "bold", bold = true },
          b = { fg = theme_colors.white, bg = theme_colors.gray, gui = "bold", bold = true },
          c = { bg = theme_colors.black, gui = "bold" },
          x = { fg = theme_colors.white, bg = theme_colors.gray, gui = "bold", bold = true },
          y = { fg = theme_colors.black, bg = theme_colors.pink, gui = "bold", bold = true },
          z = { fg = theme_colors.black, bg = theme_colors.pink, gui = "bold", bold = true },
        },
        command = {
          a = { fg = theme_colors.black, bg = theme_colors.orange, bold = true, gui = "bold" },
          b = { fg = theme_colors.white, bg = theme_colors.gray, gui = "bold", bold = true },
          c = { bg = theme_colors.black, gui = "bold", bold = true },
          x = { fg = theme_colors.white, bg = theme_colors.gray, gui = "bold", bold = true },
          y = { fg = theme_colors.black, bg = theme_colors.orange, gui = "bold", bold = true },
          z = { fg = theme_colors.black, bg = theme_colors.orange, gui = "bold", bold = true },
        },
        replace = {
          a = { fg = theme_colors.black, bg = theme_colors.yellow, bold = true },
          b = { fg = theme_colors.white, bg = theme_colors.gray, gui = "bold", bold = true },
          c = { bg = theme_colors.black, gui = "bold", bold = true },
          x = { fg = theme_colors.white, bg = theme_colors.gray, gui = "bold", bold = true },
          y = { fg = theme_colors.black, bg = theme_colors.yellow, gui = "bold", bold = true },
          z = { fg = theme_colors.black, bg = theme_colors.yellow, gui = "bold", bold = true },
        },
        inactive = {
          a = { bg = theme_colors.black },
          b = { bg = theme_colors.black },
          c = { bg = theme_colors.black },
          x = { bg = theme_colors.black },
          y = { bg = theme_colors.black },
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
          {
            "mode",
            separator = { left = "", right = "" },
          },
        },
        lualine_b = {
          { "branch", separator = { right = "" } },
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
          {
            "filename",
            file_status = true,
            path = 0,
            color = function()
              local modified = vim.bo.modified
              local fg = modified and theme_colors.yellow or theme_colors.white

              return {
                fg = fg,
                bold = true,
              }
            end,
            separator = { right = "" },
          },
        },

        ----------EMPTY MIDDLE SECTION----------
        lualine_c = {},
        ----------------------------------------

        lualine_z = {
          {
            "lsp_status",
            icon = "󰘿 ",
            symbols = {
              spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              done = "✓",
              separator = ", ",
            },
            show_name = true,
            draw_empty = false,
            separator = { left = "", right = "" },
          },
        },
      })

      opts.extensions = {}
      opts.winbar = {}
      opts.inactive_winbar = {}

      --============================================= Lualine x =============================================
      local lazy_updates = require("lazy.status").updates

      table.insert(opts.sections.lualine_x, 1, {
        function()
          return ""
        end,
        draw_empty = true,
        separator = { left = "" },
        color = { gui = "bold" },
      })

      local lualine_x_section = opts.sections.lualine_x or {}
      local new = {}

      for _, comp in ipairs(lualine_x_section) do
        if comp[1] ~= "diff" and comp[1] ~= lazy_updates then
          table.insert(new, comp)
        end
      end

      opts.sections.lualine_x = new

      --============================================= Lualine y =============================================
      table.insert(opts.sections.lualine_y, 1, {
        function()
          return ""
        end,
        draw_empty = false,
        separator = { left = "" },
        color = { gui = "bold" },
      })

      local lualine_y_section = opts.sections.lualine_y or {}
      local new_y = {}

      for _, comp in ipairs(lualine_y_section) do
        if comp[1] ~= "progress" and comp[1] ~= "location" then
          table.insert(new_y, comp)
        end
      end

      opts.sections.lualine_y = new_y

      return opts
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },
}
