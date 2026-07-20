return {
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {
      "folke/which-key.nvim",
    },
    config = function()
      local wk = require("which-key")
      local custom_border = require("lib.icons").custom_border
      wk.add({
        {
          "<leader>ct",
          "<cmd>TSManager<cr>",
          desc = "Treesitter manager",
          silent = true,
          mode = { "n" },
        },
        {
          "<c-space>",
          function()
            if vim.treesitter.get_parser(nil, nil, { error = false }) then
              require("vim.treesitter._select").select_parent(vim.v.count1)
            else
              vim.lsp.buf.selection_range(vim.v.count1)
            end
          end,
          desc = "Select parent treesitter node or outer incremental lsp selections",
          silent = true,
          mode = { "x", "o", "n" },
        },
      })

      wk.add({
        {
          "<bs>",
          function()
            local mode = vim.fn.mode()

            if mode == "n" then
              return
            end

            local start_pos = vim.fn.getpos("v")
            local end_pos = vim.fn.getpos(".")

            if vim.treesitter.get_parser(nil, nil, { error = false }) then
              require("vim.treesitter._select").select_child(vim.v.count1)
            else
              vim.lsp.buf.selection_range(-vim.v.count1)
            end

            local new_start = vim.fn.getpos("v")
            local new_end = vim.fn.getpos(".")

            if
              start_pos[2] == new_start[2]
              and start_pos[3] == new_start[3]
              and end_pos[2] == new_end[2]
              and end_pos[3] == new_end[3]
            then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            end
          end,
          desc = "Select child treesitter node or inner incremental lsp selections",
          silent = true,
          mode = { "x", "o" },
        },
      })
      require("tree-sitter-manager").setup({
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "make",
          "cpp",
          "css",
          "ghostty",
          "diff",
          "dockerfile",
          "dtd",
          "ecma",
          "git_config",
          "git_rebase",
          "gitattributes",
          "jq",
          "gitcommit",
          "gitignore",
          "tmux",
          "comment",
          "graphql",
          "typescript",
          "kdl",
          "kitty",
          "html",
          "xresources",
          "zsh",
          "html_tags",
          "http",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "jsx",
          "kotlin",
          "latex",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "ninja",
          "printf",
          "prisma",
          "python",
          "query",
          "rasi",
          "regex",
          "ron",
          "rst",
          "ruby",
          "rust",
          "just",
          "scss",
          "sql",
          "svelte",
          "toml",
          "tsx",
          "typescript",
          "tsx",
          "typst",
          "vim",
          "vimdoc",
          "vue",
          "xml",
          "yaml",
          "mermaid",
        },
        border = custom_border,
        auto_install = true,
        highlight = true,
      })
    end,
  },
}
