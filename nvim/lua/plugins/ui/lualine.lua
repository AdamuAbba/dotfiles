return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "mfussenegger/nvim-lint",
    },
    enabled = vim.env.NVIM_VIEWER ~= "1",
    event = "VeryLazy",
    opts = function(_, opts)
      local theme_colors = require("config/theme-colors")

      local separators = {
        left = "",
        right = "",
      }

      local show_linters = function()
        local ft = vim.bo.filetype
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local linters = require("lint").linters_by_ft[ft] or {}

        for _, client in ipairs(clients) do
          if client.name == "eslint" then
            table.insert(linters, "eslint")
          end
        end

        if ft == "rust" then
          table.insert(linters, "ra:Clippy")
        end

        if #linters == 0 then
          return "LNT:[None]"
        end

        return "LNT:[" .. table.concat(linters, ", ") .. "]"
      end

      local formatters_for_buf = function()
        if vim.bo.filetype == "rust" then
          return "FMT:[ra:rustfmt]"
        end
        local ret = require("conform").list_formatters(0)
        if #ret == 0 then
          return "FMT:[None]"
        end
        local names = {}
        for _, f in ipairs(ret) do
          table.insert(names, f.name)
        end
        return "FMT:[" .. table.concat(names, ", ") .. "]"
      end

      local custom_dracula_theme = {
        normal = {
          a = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          b = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          c = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          x = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          y = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          z = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
        },
        insert = {
          a = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          b = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          c = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          x = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          y = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          z = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
        },
        visual = {
          a = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          b = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          c = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          x = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          y = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          z = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
        },
        command = {
          a = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          b = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          c = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          x = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          y = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          z = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
        },
        replace = {
          a = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          b = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          c = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          x = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          y = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
          z = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
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
            separator = { left = separators.left, right = separators.right },
          },
        },
        lualine_b = {
          { "branch", separator = { right = separators.right } },
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
          {
            "filename",
            file_status = true,
            newfile_status = true,
            path = 0,
            color = function()
              local modified = vim.bo.modified
              local fg = modified and theme_colors.yellow or theme_colors.white

              return {
                fg = fg,
                bold = true,
              }
            end,
            separator = { right = separators.right },
          },
        },

        ----------EMPTY MIDDLE SECTION----------
        lualine_c = {},
        ----------------------------------------

        lualine_z = {
          {
            "lsp_status",
            icon = "",
            symbols = {
              spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              done = "✓",
              separator = ",",
            },
            show_name = true,
            draw_empty = true,
            separator = { left = separators.left },
            fmt = function(str)
              if #str == 0 then
                return "LSP:[None]"
              end
              return "LSP:[" .. str .. "]"
            end,
          },
          {
            show_linters,
            draw_empty = false,
            separator = { right = separators.right },
          },
          {
            formatters_for_buf,
            draw_empty = false,
            separator = { right = separators.right },
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
        separator = { left = separators.left },
        color = { gui = "bold" },
      })

      local lualine_x_section = opts.sections.lualine_x or {}
      -- Remove the FIRST entry (assumes Copilot is always first)
      local new = {}

      for _, comp in ipairs(lualine_x_section) do
        if comp[1] ~= "diff" and comp[1] ~= lazy_updates then
          table.insert(new, comp)
        end
      end

      table.remove(new, 1)
      table.remove(new, 2)
      opts.sections.lualine_x = new

      --============================================= Lualine y =============================================
      table.insert(opts.sections.lualine_y, 1, {
        function()
          return ""
        end,
        draw_empty = false,
        separator = { left = separators.left },
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
