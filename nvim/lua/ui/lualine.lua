-- NVIM_VIEWER=1 runs nvim as a plain viewer without a statusline (the lazy spec's `enabled`)
if vim.env.NVIM_VIEWER == "1" then
  return
end

vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

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

require("lualine").setup({
  options = {
    theme = custom_dracula_theme,
    component_separators = "",
    section_separators = "",
    globalstatus = true,
  },
  sections = {
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

    -- was LazyVim's noice/dap/profiler components, none of which can show here
    lualine_x = {},
    lualine_y = {
      {
        function()
          return ""
        end,
        draw_empty = false,
        separator = { left = separators.left },
        color = { gui = "bold" },
      },
    },
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
  },
  extensions = {},
  winbar = {},
  inactive_winbar = {},
})
