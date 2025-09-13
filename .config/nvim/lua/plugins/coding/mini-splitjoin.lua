return {
  {
    "echasnovski/mini.splitjoin",
    config = function()
      local miniSplitJoin = require("mini.splitjoin")
      local wk = require("which-key")

      miniSplitJoin.setup({
        mappings = {
          toggle = "",
        },
      })

      wk.add({
        {
          "<leader>cb",
          group = "Split/Join",
          icon = "󱤗",
        },
        {
          "<leader>cbj",
          function()
            miniSplitJoin.join()
          end,
          icon = "󰮸",
          desc = "Join arguments",
          mode = { "n", "x" },
        },
        {
          "<leader>cbs",
          function()
            miniSplitJoin.split()
          end,
          icon = "󰮾",
          desc = "Split arguments",
          mode = { "n", "x" },
        },
      })
    end,
  },
}
