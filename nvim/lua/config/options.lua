-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

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

vim.g.bufstate_no_default_maps = 1
--=============================================  LazyVim Options ==============================================
g.lazyvim_blink_main = true
g.autoformat = false
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

--============================================= Buffer  Options ==============================================
opt_local.spell = false
