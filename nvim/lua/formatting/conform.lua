vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

------ prettier only runs where the project has a prettier config
------ (was LazyVim's prettier extra with vim.g.lazyvim_prettier_needs_config = true)
local has_prettier_config = {} -- filename -> boolean, so prettier isn't asked on every format
local function prettier_condition(_, ctx)
  if has_prettier_config[ctx.filename] == nil then
    vim.fn.system({ "prettier", "--find-config-path", ctx.filename })
    has_prettier_config[ctx.filename] = vim.v.shell_error == 0
  end
  return has_prettier_config[ctx.filename]
end

require("conform").setup({
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    css = { "prettier" },
    eruby = { "erb_format" },
    fish = { "fish_indent" },
    graphql = { "prettier" },
    handlebars = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    kotlin = { "ktlint" },
    less = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    ["markdown.mdx"] = { "prettier" },
    nix = { "nixfmt" },
    python = { "black" },
    ruby = { "rubocop" },
    scss = { "prettier" },
    sh = { "shfmt" },
    toml = { "tombi" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    yaml = { "prettier" },
    zsh = { "shfmt" },
  },
  formatters = {
    injected = { options = { ignore_errors = true } },
    prettier = { condition = prettier_condition },
  },
})

-- gq formats through conform (LazyVim pointed this at its own wrapper)
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set({ "n", "x" }, "<leader>cF", function()
  require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
end, { desc = "Format Injected Langs" })
