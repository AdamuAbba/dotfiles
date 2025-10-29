return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
        float = {
          border = "rounded",
        },
      })

      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        bacon_ls = {
          ---@diagnostic disable-next-line: undefined-global
          enabled = diagnostics == "bacon-ls",
        },
        rust_analyzer = { enabled = false },
        vectorcode_server = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                library = {
                  vim.env.VIMRUNTIME,
                },
                checkThirdParty = false,
              },
            },
          },
        },
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
      })
    end,
  },
}
