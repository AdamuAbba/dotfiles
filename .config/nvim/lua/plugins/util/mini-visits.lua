return {
  {
    "nvim-mini/mini.visits",
    version = false,
    config = function(_, opts)
      local mini_visits = require("mini.visits")
      local icons = require("lib.icons")

      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)

      opts.window = {
        config = {
          border = icons.custom_border,
          relative = "editor",
          anchor = "NW",
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        },
      }

      mini_visits.setup(opts)
    end,
  },
}
