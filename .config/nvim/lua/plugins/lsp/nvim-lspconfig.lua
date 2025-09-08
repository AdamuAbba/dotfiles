return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      ---@diagnostic disable-next-line: undefined-doc-name
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
                  ---@diagnostic disable-next-line: undefined-global
                  vim.fn.expand("~/.hammerspoon/Spoons/EmmyLua.spoon/annotations"),
                  vim.fn.expand("~/.hammerspoon"),
                },
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
