return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    opts = {
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
      inc_search = "background", -- underline | background
      background_clear = {
        "toggleterm",
        "telescope",
        "renamer",
        "notify",
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
        local highlight_overrides = require("config.highlight-overrides")
        return highlight_overrides.groups
      end,
    },
    config = function(_, opts)
      require("monokai-pro").setup(opts)
      vim.cmd.colorscheme("monokai-pro")
    end,
  },
}
