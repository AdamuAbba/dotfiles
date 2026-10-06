-- Loaded first by init.lua, so mapleader is set before any keymap exists

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.env.RIPGREP_CONFIG_PATH = vim.fn.expand("~/.ripgreprc")

local o = vim.o
local g = vim.g
local opt_local = vim.opt_local
local lsp = vim.lsp
local ui2 = require("vim._core.ui2")

ui2.enable({
  enable = true,
  msg = {
    targets = "msg",
    cmd = {
      height = 1,
    },
    dialog = {
      height = 1,
    },
    msg = {
      height = 1,
      timeout = 4000,
    },
    pager = {
      height = 1,
    },
  },
})

--=============================================  LSP ==============================================
lsp.document_color.enable(true, nil, { style = "background" })

--=============================================  Globals ==============================================
g.skip_ts_context_commentstring_module = true
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0
--============================================= set filetypes =============================================
vim.filetype.add({
  filename = {
    ["tmux.conf"] = "tmux",
    ["*ghostty/config"] = "ghostty",
  },
  pattern = {
    [".git/hooks/.*"] = "sh",
    [".*/Podfile"] = "ruby",
  },
})

--=============================================  Options ==============================================
o.conceallevel = 0
o.concealcursor = ""
o.termguicolors = true
o.cursorline = true
o.cursorcolumn = true
o.number = true
o.relativenumber = true
o.signcolumn = "no"
o.laststatus = 3
o.showmode = false
o.swapfile = false
o.clipboard = "unnamedplus"
o.mouse = ""
o.winbar = ""
o.winborder = "rounded"
o.ignorecase = true
o.smartcase = true
o.autoread = true
o.infercase = true
o.showcmd = false
o.spell = false
o.cmdwinheight = 20
o.wildmode = "noselect"
o.wildoptions = "pum,fuzzy"
o.pumborder = "rounded"
o.pumheight = 10
o.pummaxwidth = 65
o.cmdheight = 1
o.autocomplete = true
o.complete = ".,o"
o.completeopt = "noinsert,menu,menuone,popup,fuzzy,noselect"

--============================================= Editing defaults (formerly LazyVim's) ==============================================
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.shiftround = true
o.smartindent = true
o.wrap = false
o.linebreak = true
o.list = true
o.scrolloff = 4
o.sidescrolloff = 8
o.smoothscroll = true
o.splitbelow = true
o.splitright = true
o.splitkeep = "screen"
o.winminwidth = 5
o.confirm = true
o.autowrite = true
o.undofile = true
o.undolevels = 10000
o.timeoutlen = 300
o.updatetime = 200
o.virtualedit = "block"
o.jumpoptions = "view"
o.ruler = false
o.pumblend = 10
o.foldlevel = 99
o.foldmethod = "indent"
o.foldtext = ""
o.formatoptions = "jcroqlnt"
o.fillchars = "foldopen:,foldclose:,fold: ,foldsep: ,diff:╱,eob: "
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
g.markdown_recommended_style = 0

--============================================= Buffer  Options ==============================================
opt_local.spell = false
