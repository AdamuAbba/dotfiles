return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          grug.with_visual_selection({
            transient = true,
            prefills = { paths = vim.fn.expand("%") },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
