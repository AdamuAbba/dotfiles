---@type vim.lsp.Config
return {
  cmd = { "/opt/homebrew/bin/lua-language-server" },
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
