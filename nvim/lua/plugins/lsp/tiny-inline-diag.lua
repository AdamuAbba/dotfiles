return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "powerline",
        transparent_cursorline = true,
        options = {
          show_source = {
            enabled = true,
          },
          multilines = {
            enabled = true,
            always_show = true,
            trim_whitespaces = true,
            tabstop = 2,
          },
          enable_on_select = true,
          overflow = {
            mode = "wrap",
            padding = 0,
          },
          softwrap = 25,
          override_open_float = true,
          show_all_diags_on_cursorline = false,
          show_diags_only_under_cursor = false,
          break_line = {
            enabled = true,
            after = 40,
          },
        },
      })
    end,
  },
}
