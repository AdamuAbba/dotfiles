---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      hint = {
        enable = true,
        semicolon = "Disable",
        arrayIndex = "Disable",
        await = true,
        awaitPropagte = true,
        paramType = true,
        paramName = "All",
        setType = true,
      },
      codeLens = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}
