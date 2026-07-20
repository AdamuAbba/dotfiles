-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.env.RIPGREP_CONFIG_PATH = vim.fn.expand("~/.ripgreprc")

local opt = vim.o
local opt_local = vim.opt_local
local g = vim.g
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
      height = 0.5,
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

vim.g.bufstate_no_default_maps = 1
--=============================================  LazyVim Options ==============================================
g.lazyvim_blink_main = true
g.autoformat = false
g.snacks_animate = true
g.trouble_lualine = false
g.ai_cmp = false
g.trouble_lualine = false

--- LSP
lsp.document_color.enable(true, nil, { style = "background" })
g.lazyvim_ts_lsp = "tsgo"
g.lazyvim_eslint_auto_format = false

-- Formatter
g.lazyvim_prettier_needs_config = true

--=============================================  Globals ==============================================
g.skip_ts_context_commentstring_module = true
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0
--zenbones specifics
vim.g.zenbones = {
  solid_line_nr = false,
  transparent_background = false,
  italic_strings = false,
  italic_comments = false,
  solid_float_border = true,
}
--============================================= set filetypes =============================================
vim.filetype.add({
  filename = {
    ["tmux.conf"] = "tmux",
    [".tmux.conf"] = "tmux",
  },
  pattern = {
    [".git/hooks/.*"] = "sh",
    [".*/Podfile"] = "ruby",
  },
})

--=============================================  Options ==============================================
opt.conceallevel = 0
opt.concealcursor = ""
opt.termguicolors = true
opt.cursorline = true
opt.cursorcolumn = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "no"
opt.laststatus = 3
opt.showmode = false
opt.swapfile = false
opt.clipboard = "unnamedplus"
opt.mouse = ""
opt.winbar = ""
opt.winborder = "rounded"
opt.ignorecase = true
opt.smartcase = true
opt.autoread = true
opt.infercase = true
opt.showcmd = false
opt.spell = false
---completion
opt.wildmode = "noselect"
opt.wildoptions = "pum,fuzzy"
opt.pumborder = "rounded"
opt.pumheight = 7
opt.pummaxwidth = 65
opt.cmdheight = 0
opt.autocomplete = true
opt.complete = ".,o"
opt.completeopt = "preview,noinsert,menu,menuone,popup,fuzzy,noselect"

--============================================= Buffer  Options ==============================================
opt_local.spell = false
