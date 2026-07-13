---@type vim.lsp.Config
return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  --- @type lspconfig.settings.vtsls
  --- using vtsls types since it's same with tsgo (I think?)
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = {
          enabled = "literals",
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
