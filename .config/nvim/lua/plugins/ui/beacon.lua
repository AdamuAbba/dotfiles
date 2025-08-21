local theme_color = require("config.theme-colors")
return {
  {
    "danilamihailov/beacon.nvim",
    opts = {
      enabled = true,
      speed = 2,
      width = 40,
      winblend = 40, --- integer starting transparency of beacon window :h winblend
      fps = 60,
      min_jump = 3,
      cursor_events = { "CursorMoved" },
      window_events = { "WinEnter", "FocusGained" },
      highlight = { bg = theme_color.green, ctermbg = 84 },
    },
  },
}
