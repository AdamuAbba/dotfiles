return {
  {
    "nvim-mini/mini.trailspace",
    version = false,
    config = function()
      local miniTrailspace = require("mini.trailspace")
      local wk = require("which-key")

      miniTrailspace.setup()

      wk.add({
        {
          "<leader>cw",
          function()
            miniTrailspace.trim()
          end,
          icon = " ",
          desc = "Erase Whitespace",
          silent = true,
          mode = { "n" },
        },
      })
    end,
  },
}
