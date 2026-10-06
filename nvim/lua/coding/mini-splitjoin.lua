vim.pack.add({ "https://github.com/nvim-mini/mini.splitjoin" })

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
    "<leader>cbk",
    function()
      miniSplitJoin.join()
    end,
    icon = "󰮸",
    desc = "Join arguments",
    mode = { "n", "x" },
  },
  {
    "<leader>cbj",
    function()
      miniSplitJoin.split()
    end,
    icon = "󰮾",
    desc = "Split arguments",
    mode = { "n", "x" },
  },
})
