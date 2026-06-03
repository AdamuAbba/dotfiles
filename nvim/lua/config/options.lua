-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.env.RIPGREP_CONFIG_PATH = vim.fn.expand("~/.ripgreprc")

local opt = vim.o
local opt_local = vim.opt_local
local g = vim.g
local lsp = vim.lsp

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
g.lazyvim_rust_diagnostics = "rust-analyzer"

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
  solid_float_border = true
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
opt.guicursor = "n:block-blinkon0,"
  -- visual mode
  .. "v:block-blinkon0,"
  -- insert mode
  .. "i-ci-ve:ver75-blinkon0,"
  -- command mode
  .. "c:block-blinkon0,"
  .. "c-ci-ve:ver25-blinkon0,"
  -- replace mode
  .. "r-cr-o:hor20-blinkon500-blinkoff500,"

opt.conceallevel = 0
opt.concealcursor = ""
opt.termguicolors = true
opt.cursorline = true
opt.cursorcolumn = true
opt.number = true
opt.relativenumber = false
opt.signcolumn = "yes"
opt.laststatus = 3
opt.showmode = false
opt.swapfile = false
opt.clipboard = "unnamedplus"
opt.mouse = ""
opt.winbar = " "
opt.winborder = "rounded"
opt.ignorecase = true
opt.smartcase = true
opt.autoread = true
opt.infercase = true
opt.showcmd = false
opt.spell = false
opt.pumborder = "rounded"

--============================================= Buffer  Options ==============================================
opt_local.spell = false
