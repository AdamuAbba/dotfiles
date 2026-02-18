local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local custom_border = require("lib.icons").custom_border

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
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
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.cmake" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.sql" },
    { import = "lazyvim.plugins.extras.lang.git" },
    { import = "lazyvim.plugins.extras.lang.java" },
    { import = "lazyvim.plugins.extras.lang.kotlin" },
    { import = "lazyvim.plugins.extras.lang.ruby" },
    { import = "lazyvim.plugins.extras.lang.clangd" },
    { import = "lazyvim.plugins.extras.lang.prisma" },
    { import = "lazyvim.plugins.extras.lang.vue" },

    --============================================= linting extras ============================================
    { import = "lazyvim.plugins.extras.linting.eslint" },

    --============================================= formatting extras =========================================
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.formatting.biome" },
    { import = "lazyvim.plugins.extras.formatting.black" },

    --============================================= editor extras =============================================
    { import = "lazyvim.plugins.extras.editor.mini-move" },
    { import = "lazyvim.plugins.extras.editor.mini-diff" },
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    { import = "lazyvim.plugins.extras.editor.inc-rename" },

    --============================================= util extras ===============================================
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.util.dot" },
    { import = "lazyvim.plugins.extras.util.rest" },

    --============================================= coding extras =============================================
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.coding.blink" },
    { import = "lazyvim.plugins.extras.coding.neogen" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.coding.mini-comment" },
    { import = "lazyvim.plugins.extras.coding.luasnip" },

    --============================================= test extras ===============================================
    { import = "lazyvim.plugins.extras.test.core" },

    --============================================= debug-adapter extras ======================================
    { import = "lazyvim.plugins.extras.dap.core" },

    --============================================= ai extras =================================================
    { import = "lazyvim.plugins.extras.ai.copilot" },

    --============================================= ui extras =================================================
    { import = "lazyvim.plugins.extras.ui.smear-cursor" },

    --============================================= import my plugins =====================================
    { import = "plugins" },
    { import = "plugins.linting" },
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.coding" },
    { import = "plugins.lsp" },
    { import = "plugins.test" },
    { import = "plugins.dap" },
    { import = "plugins.util" },
    { import = "plugins.ai" },

    ------- my language extras
    { import = "plugins.lang.markdown" },
    { import = "plugins.lang.typescript" },
    { import = "plugins.lang.rust" },
    { import = "plugins.lang.ghostty" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "dracula" },
  },
  ui = {
    border = custom_border,
    backdrop = 100,
    title = " Lazy ",
    title_pos = "left",
  },
  checker = {
    enabled = vim.env.NVIM_VIEWER ~= "1",
  },
  performance = {
    rtp = {
      disabled_plugins = {},
    },
  },
})
