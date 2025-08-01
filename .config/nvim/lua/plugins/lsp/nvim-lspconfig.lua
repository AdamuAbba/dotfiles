return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      ---@diagnostic disable-next-line: undefined-doc-name
      opts.diagnostics = {
        float = {
          border = "rounded",
        },
      }

      opts.servers = {
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
      }

      return opts
    end,
  },
}
