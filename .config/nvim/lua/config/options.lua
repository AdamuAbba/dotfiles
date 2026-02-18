-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.env.RIPGREP_CONFIG_PATH = vim.fn.expand("~/.ripgreprc")

local opt = vim.o
local g = vim.g

--=============================================  Globals ==============================================
g.skip_ts_context_commentstring_module = true
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0
-- LazyVim specifics
g.lazyvim_prettier_needs_config = true
g.lazyvim_blink_main = true
g.autoformat = false
g.snacks_animate = true
g.trouble_lualine = false
g.ai_cmp = false
g.trouble_lualine = false
--zenbones specifics
vim.g.zenbones = {
  solid_line_nr = false,
  transparent_background = false,
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
opt.guicursor = "n:block-blinkon500-blinkoff500,"
  -- visual mode
  .. "v:block-blinkon500-blinkoff500,"
  -- insert mode
  .. "i-ci-ve:ver75-blinkon500-blinkoff500,"
  -- command mode
  .. "c:block-blinkon500-blinkoff500,"
  .. "c-ci-ve:ver25-blinkon500-blinkoff500,"
  -- replace mode
  .. "r-cr-o:hor20-blinkon500-blinkoff500,"
  -- showmatch mode
  .. "sm:block-blinkon500-blinkoff500,"
  -- terminal mode
  .. "t:block-blinkon500-blinkoff500-TermCursor,"
  .. "a:SmearCursorHideable"
opt.conceallevel = 0
opt.concealcursor = ""
opt.termguicolors = true
opt.cursorline = true
opt.cursorcolumn = true
opt.number = true
opt.relativenumber = true
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
