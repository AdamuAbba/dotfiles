return {
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = function()
      return {
        modes = { insert = true, command = true, terminal = false },
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" },

          [")"] = { action = "close", pair = "()", neigh_pattern = "^[^\\]" },
          ["]"] = { action = "close", pair = "[]", neigh_pattern = "^[^\\]" },
          ["}"] = { action = "close", pair = "{}", neigh_pattern = "^[^\\]" },

          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "^[^\\]", register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[^%a\\]", register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "^[^\\]", register = { cr = false } },
        },
      }
    end,
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
}
