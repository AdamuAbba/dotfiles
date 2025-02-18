local HOME = os.getenv("HOME")

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = {
            "--config",
            HOME .. "/dotfiles/.config/nvim/lua/plugins/linting/.markdownlint-cli2.yaml",
            "--",
          },
        },
      },
    },
  },
}
