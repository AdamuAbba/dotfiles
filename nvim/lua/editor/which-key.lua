vim.pack.add({ "https://github.com/folke/which-key.nvim" })

local wk = require("which-key")

wk.setup({
  preset = "helix",
  spec = {
    -- group names LazyVim used to provide (lazyvim/plugins/editor.lua)
    {
      mode = { "n", "x" },
      { "<leader><tab>", group = "tabs" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>dp", group = "profiler" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>gh", group = "hunks" },
      { "<leader>q", group = "quit/session" },
      { "<leader>s", group = "search" },
      { "<leader>u", group = "ui" },
      { "<leader>x", group = "diagnostics/quickfix" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gs", group = "surround" },
      { "z", group = "fold" },
      {
        "<leader>w",
        group = "windows",
        proxy = "<c-w>",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
      { "gx", desc = "Open with system app" },
    },
    -- mine
    { "<leader>b", group = "buffer", expand = false },
    { "<leader>gd", group = "Git Diff" },
  },
  plugins = {
    marks = true,
    registers = true,
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
    spelling = {
      enabled = false,
    },
  },
  icons = {
    breadcrumb = "»",
    group = "+",
    ellipsis = "…",
    separator = "│",
    mappings = false,
  },
  win = {
    no_overlap = true,
    border = "rounded",
    width = 31,
    height = { max = 35 },
    title = true,
    zindex = 1000,
    wo = {
      winblend = 0,
    },
  },
  show_help = false,
  show_keys = true,
})

vim.keymap.set("n", "<leader>?", function()
  wk.show({ global = false })
end, { desc = "Buffer Keymaps (which-key)" })
vim.keymap.set("n", "<c-w><space>", function()
  wk.show({ keys = "<c-w>", loop = true })
end, { desc = "Window Hydra Mode (which-key)" })
