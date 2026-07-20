return {
  {
    "tmm/ghostty-navigator.nvim",
    build = "make",
    opts = {
      keys = {
        ["<C-h>"] = "h",
        ["<C-j>"] = "j",
        ["<C-k>"] = "k",
        ["<C-l>"] = "l",
      },
    },
  },
}
