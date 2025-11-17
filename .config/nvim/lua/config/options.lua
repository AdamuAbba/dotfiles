-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.o
local g = vim.g
local w = vim.wo

--============================================= Undercurl =============================================
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

--=============================================  Globals ==============================================
g.skip_ts_context_commentstring_module = true
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0
-- g.python3_host_prog = "/Users/abba/.pyenv/versions/neovim/bin/python"
g.lazyvim_prettier_needs_config = true
g.lazyvim_blink_main = true
g.ai_cmp = false
g.trouble_lualine = false
--=============================================  Options ==============================================
opt.termguicolors = true
opt.cursorline = true
opt.cursorcolumn = true
opt.number = true
opt.laststatus = 3
opt.showmode = false
opt.swapfile = false
opt.clipboard = "unnamedplus"
opt.mouse = ""
opt.winbar = " "
opt.winborder = "rounded"
--=============================================  window scoped ==============================================
w.relativenumber = false
