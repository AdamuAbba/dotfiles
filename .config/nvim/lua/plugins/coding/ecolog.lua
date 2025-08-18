return {
  {
    "ph1losof/ecolog.nvim",
    keys = {
      -- { "<leader>e", "", desc = "+ecolog", mode = { "n", "v" } },
      -- { "<leader>el", "<Cmd>EcologShelterLinePeek<cr>", desc = "Peek line" },
      -- { "<leader>ey", "<Cmd>EcologCopy<cr>", desc = "Copy value under cursor" },
      -- { "<leader>ei", "<Cmd>EcologInterpolationToggle<cr>", desc = "Toggle interpolation" },
      -- { "<leader>eh", "<Cmd>EcologShellToggle<cr>", desc = "Toggle shell variables" },
      -- { "<leader>ge", "<cmd>EcologGoto<cr>", desc = "Go to env file" },
      -- { "<leader>ec", "<cmd>EcologSnacks<cr>", desc = "Open a picker" },
      -- { "<leader>eS", "<cmd>EcologSelect<cr>", desc = "Switch env file" },
      -- { "<leader>es", "<cmd>EcologShelterToggle<cr>", desc = "Shelter toggle" },
    },
    opts = {
      provider_patterns = true,
      monorepo = true,
      load_shell = {
        enabled = true,
        override = false,
        transform = function(key, value)
          return "[shell] " .. value
        end,
      },
      interpolation = true,
      integrations = {
        lsp = false,
        nvim_cmp = false,
        omnifunc = true,
        lspsaga = false,
        blink_cmp = true,
        snacks = true,
        statusline = false,
      },
    },
  },
}
