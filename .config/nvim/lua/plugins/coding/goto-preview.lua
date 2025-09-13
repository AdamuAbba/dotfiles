return {
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = function(_, opts)
      require("goto-preview").setup(opts)
      local go_to_preview = require("goto-preview")
      local wk = require("which-key")

      wk.add({
        { "gb", group = "Goto Preview", icon = " ", mode = { "n" } },
        { "gbd", go_to_preview.goto_preview_definition, icon = "", desc = "Preview Definition" },
        { "gbq", go_to_preview.close_all_win, icon = "", desc = "Close Preview Windows" },
        {
          "gbt",
          go_to_preview.goto_preview_type_definition,
          icon = "󰙅",
          desc = "Preview Type Definition",
        },
      })
    end,
  },
}
