return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- LSP Server Settings
      -- Sets the default configuration for an LSP client (or all clients if the special name "*" is used).
      ---@diagnostic disable-next-line: duplicate-doc-alias
      ---@alias lazyvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean, keys?:LazyKeysLspSpec[]}
      ---@type table<string, lazyvim.lsp.Config|boolean>
      opts.servers = {
        ["*"] = {
          keys = {},
        },
      }
      return opts
    end,
  },
}
