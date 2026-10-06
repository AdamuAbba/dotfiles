vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

lint.linters_by_ft = {
  bash = { "shellcheck" },
  cmake = { "cmakelint" },
  dockerfile = { "hadolint" },
  gitcommit = { "gitlint" },
  html = { "htmlhint" },
  kotlin = { "ktlint" },
  lua = { "selene" },
  markdown = { "markdownlint-cli2" },
  python = { "ruff" },
  sh = { "shellcheck" },
  toml = { "tombi" },
  zsh = { "shellcheck" },
  -- [ts, js, tsx, json, jsonc, … ] linting is handled by the eslint LSP server
}

------ markdownlint uses the repo-wide config
------ (no "--" before nvim-lint's "-": after "--", markdownlint reads "-" as a filename instead of stdin)
local markdownlint = lint.linters["markdownlint-cli2"]
markdownlint.args = vim.list_extend(
  { "--config", os.getenv("HOME") .. "/Documents/dotfiles/.markdownlint-cli2.jsonc" },
  markdownlint.args or {}
)

------ selene only reads selene.toml (and the vim.yml it names) from its working directory,
------ so run it from the nearest folder above the buffer that has one
lint.linters.selene = function()
  return vim.tbl_extend("force", require("lint.linters.selene"), { cwd = vim.fs.root(0, "selene.toml") })
end

------ lint on open, save and leaving insert mode; the debounce collapses a burst of events into one run
local timer = vim.uv.new_timer()
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    timer:start(
      100,
      0,
      vim.schedule_wrap(function()
        lint.try_lint()
      end)
    )
  end,
})
