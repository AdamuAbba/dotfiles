---@type vim.lsp.Config
return {
  -- Homebrew's copy, named by full path: the gem copy in ~/.gem/ruby/*/bin comes
  -- first on PATH and is a broken install. Started from the project root, the same
  -- way nvim-lspconfig's own cmd does it.
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start(
      { "/opt/homebrew/bin/ruby-lsp" },
      dispatchers,
      config and config.root_dir and { cwd = config.cmd_cwd or config.root_dir }
    )
  end,
}
