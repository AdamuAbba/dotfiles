return {
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
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
}
