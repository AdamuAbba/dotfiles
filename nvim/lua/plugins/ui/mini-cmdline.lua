return {
  {
    "nvim-mini/mini.cmdline",
    version = false,
    config = function(_, opts)
      opts.autocomplete = {
        enable = true,
      }

      opts.autocorrect = {
        enable = false,
      }

      opts.autopeek = {
        enable = true,
        n_context = 1,
        window = {
          config = {
            relative = "editor",
            anchor = "NW",
            -- row = math.floor(vim.o.lines / 2) - 3.5,
            -- col = math.floor(vim.o.columns / 2) - 31,
            width = 40,
            border = "rounded",
          },
        },
      }
      require("mini.cmdline").setup(opts)
    end,
  },
}
