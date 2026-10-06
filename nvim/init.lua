-- Each lua/<category>/<plugin>.lua installs and configures one plugin when required.
-- Order below is load order: nothing is automatic.
require("config.options")

--============================================= ui ==============================================
require("ui.mini-icons")
require("ui.monokai-pro")
require("ui.lualine")
require("ui.indent-blankline")
require("ui.mini-cmdline")

--============================================= editor ==========================================
require("editor.which-key")
require("editor.better-escape")
require("editor.gitsigns")
require("editor.oil")
require("editor.grug-far")
require("editor.codediff")

--============================================= coding ==========================================
require("coding.tree-sitter-manager")
require("coding.mini-pairs")
require("coding.mini-surround")
require("coding.mini-splitjoin")
require("coding.nvim-ts-context-commentstring")
require("coding.mini-comment")
require("coding.ts-comments")
require("coding.nvim-ts-autotag")
require("coding.goto-preview")
require("coding.mini-snippets")
require("coding.nvim-scissors")
require("coding.neogen")
require("coding.lazydev")

--============================================= lsp =============================================
require("lsp.nvim-lspconfig")
require("lsp.schemastore")

--============================================= formatting ======================================
require("formatting.conform")

--============================================= linting =========================================
require("linting.nvim-lint")

--============================================= lang ============================================
require("lang.crates")
require("lang.live-preview")

--============================================= util ============================================
require("util.committia")
require("util.vim-tmux-navigator")

--============================================= ai ==============================================
require("ai.claudecode")

--============================================= shared config ===================================
require("config.keymaps")
require("config.autocmds")
require("config.lsp")
require("config.usercmds")
require("config.file_picker")
require("config.keymap_list")
require("config.highlight_list")
