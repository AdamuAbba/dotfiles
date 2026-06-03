return {
  {
    "not-manu/filemention.nvim",
    event = "InsertEnter",
    opts = {},
    config = function()
      require("filemention").setup({
        trigger = "@",
        root = "git",
        respect_gitignore = true,
        include_hidden = false,
        format = "bare",
        filetypes = { "markdown", "text", "gitcommit" }, -- or "*" if you live dangerously
        max_items = 500,
        finder = "auto",
      })
    end,
  },
}
