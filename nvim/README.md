# Neovim Configuration

My personal Neovim configuration: plain Neovim 0.12 with the built-in `vim.pack`
plugin manager. Plugins install on first launch; exact versions are pinned in
`nvim-pack-lock.json`.

## Structure

- **`init.lua`**: load order. Options first, then one module per plugin, then
  shared config.
- **`lua/<category>/<plugin>.lua`**: installs (`vim.pack.add`) and configures
  one plugin.
- **`lua/config/`**: options, keymaps, autocmds, LSP setup and user commands.
- **`after/lsp/<server>.lua`**: per-server LSP settings. Servers are switched on
  in `lua/config/lsp.lua`.
- **`plugin/`**: small hand-written plugins (grep, line moving, sessions).
- **`snippets/`**, **`templates/`**: snippets and new-file templates.

Language servers, formatters and linters are installed separately, mostly with
Homebrew.
