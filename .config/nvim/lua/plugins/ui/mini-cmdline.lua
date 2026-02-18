return {
  {
    "nvim-mini/mini.cmdline",
    version = false,
    config = function(_, opts)
      local custom_border = require("lib.icons").custom_border
      opts.autocomplete = {
        enable = false,
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
            row = math.floor(vim.o.lines / 2) - 2,
            col = math.floor(vim.o.columns / 2) - 32,
            width = 40,
            border = custom_border,
          },
        },
      }
      require("mini.cmdline").setup(opts)
    end,
  },
}
