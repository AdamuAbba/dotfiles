return {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    "folke/which-key.nvim",
  },
  opts = function()
    return {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local wk = require("which-key")

        wk.add({
          { "<leader>gb", group = "Git Blame", mode = { "n" } },
          {
            "<leader>gbl",
            function()
              gs.blame_line({ full = false })
            end,
            desc = "Blame Line",
            silent = true,
            buffer = buffer,
            mode = "n",
          },
          {
            "<leader>gbb",
            function()
              gs.blame()
            end,
            desc = "Blame Buffer",
            silent = true,
            buffer = buffer,
            mode = "n",
          },
        })
      end,
    }
  end,
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end,
}
