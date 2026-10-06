---@type vim.lsp.Config
return {
  cmd_env = { RUFF_TRACE = "messages" },
  init_options = { settings = { logLevel = "error" } },
  -- hover comes from pyright instead
  on_init = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
