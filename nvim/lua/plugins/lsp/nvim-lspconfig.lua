return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- LSP Server Settings
      -- Sets the default configuration for an LSP client (or all clients if the special name "*" is used).
      ---@diagnostic disable-next-line: duplicate-doc-alias
      ---@alias lazyvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean, keys?:LazyKeysLspSpec[]}
      ---@type table<string, lazyvim.lsp.Config|boolean>
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        -- installed via cargo, not mason. `mason = false` makes LazyVim call
        -- vim.lsp.enable() itself instead of deferring to mason-lspconfig.
        rust_analyzer = { mason = false },
        bacon_ls = { mason = false },
        tsc = { mason = false },
        lua_ls = { mason = false },
        selene = { mason = false },
      })

      -- LazyVim registers a keymap for every `servers.<name>.keys` entry on
      -- LspAttach: the shared set under "*", plus per-server ones from extras
      -- (clangd's <leader>ch, copilot's <leader>a*). Drop them all; ours live in
      -- config/lsp.lua. Assigned rather than merged, since deep-extending an
      -- empty list onto a populated one leaves the original entries in place.
      for _, server in pairs(opts.servers) do
        if type(server) == "table" then
          server.keys = nil
        end
      end

      return opts
    end,
  },
}
