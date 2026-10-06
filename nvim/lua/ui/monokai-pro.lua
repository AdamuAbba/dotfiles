vim.pack.add({
  { src = "https://github.com/loctvl842/monokai-pro.nvim", name = "monokai-pro" },
})

require("monokai-pro").setup({
  transparent_background = true,
  terminal_colors = true,
  devicons = false,
  styles = {
    comment = { italic = false },
    keyword = { italic = false },
    type = { italic = false },
    storageclass = { italic = false },
    structure = { italic = false },
    parameter = { italic = false },
    annotation = { italic = false },
    tag_attribute = { italic = false },
  },
  filter = "classic", -- classic | octagon | pro | machine | ristretto | spectrum
  day_night = {
    enable = false,
    day_filter = "classic",
    night_filter = "classic",
  },
  inc_search = "background",
  background_clear = {
    "which-key",
  },
  disabled_plugins = { "bufferline", "neo-tree" },
  plugins = {
    indent_blankline = {
      context_highlight = "default", -- default | pro
      context_start_underline = true,
    },
  },
  override = function(_)
    return require("config.highlight-overrides").groups
  end,
})
vim.cmd.colorscheme("monokai-pro")
