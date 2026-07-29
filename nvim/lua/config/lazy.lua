local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup({
  opts = {
    pkg = {
      enabled = true,
      cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
      sources = {
        "lazy",
        "rockspec",
        "packspec",
      },
    },
    rocks = {
      root = vim.fn.stdpath("data") .. "/lazy-rocks",
      server = "https://nvim-neorocks.github.io/rocks-binaries/",
    },
  },
  spec = {
    --============================================= add LazyVim and import its plugins ========================
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    --============================================= languages extras ==========================================
    { import = "lazyvim.plugins.extras.lang.typescript.tsgo" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.cmake" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.sql" },
    { import = "lazyvim.plugins.extras.lang.git" },
    { import = "lazyvim.plugins.extras.lang.java" },
    { import = "lazyvim.plugins.extras.lang.kotlin" },
    { import = "lazyvim.plugins.extras.lang.ruby" },
    { import = "lazyvim.plugins.extras.lang.clangd" },

    --============================================= linting extras ============================================
    { import = "lazyvim.plugins.extras.linting.eslint" },

    --============================================= formatting extras =========================================
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.formatting.black" },

    --============================================= util extras ===============================================
    { import = "lazyvim.plugins.extras.util.dot" },
    { import = "lazyvim.plugins.extras.util.rest" },

    --============================================= ai extras =================================================
    { import = "lazyvim.plugins.extras.ai.copilot-native" },

    --============================================= import my plugins =====================================
    { import = "plugins" },
    { import = "plugins.linting" },
    { import = "plugins.formatting" },
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.coding" },
    { import = "plugins.lsp" },
    { import = "plugins.dap" },
    { import = "plugins.util" },
    { import = "plugins.ai" },

    ------- my language extras
    { import = "plugins.lang.markdown" },
    { import = "plugins.lang.rust" },
    { import = "plugins.lang.ghostty" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    missing = true,
    colorscheme = { "zenbones" },
  },
  ui = {
    border = "rounded",
    backdrop = 100,
    title = " Lazy ",
    title_pos = "left",
  },
  checker = {
    enabled = vim.env.NVIM_VIEWER ~= "1",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {},
    },
  },
})
