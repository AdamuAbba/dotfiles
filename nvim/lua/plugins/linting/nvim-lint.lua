return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local HOME = os.getenv("HOME")

      opts.linters = vim.tbl_deep_extend("force", opts.linters or {}, {
        ["markdownlint-cli2"] = {
          prepend_args = { "--config", HOME .. "/Documents/dotfiles/.markdownlint-cli2.jsonc", "--" },
        },
      })
      opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft or {}, {
        gitcommit = { "gitlint" },
        html = { "htmlhint" },
        lua = { "selene" },
        python = { "ruff" },
        bash = { "shellcheck" },
        sh = { "shellcheck" },
        zsh = { "shellcheck" },
        toml = { "tombi" },
        markdown = { "markdownlint-cli2" },
        -- [ts, js, tsx, json, jsonc, … ] linting
        -- all handled by eslint LSP server
      })
      return opts
    end,
  },
}
