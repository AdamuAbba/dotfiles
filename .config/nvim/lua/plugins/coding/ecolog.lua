return {
  {
    "ph1losof/ecolog.nvim",
    lazy = false,
    config = function(_, opts)
      local ecolog = require("ecolog")
      opts.integrations = {
        blink_cmp = true,
      }
      ecolog.setup(opts)
    end,
  },
}
