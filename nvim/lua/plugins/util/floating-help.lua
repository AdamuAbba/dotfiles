return {
  {
    "Tyler-Barham/floating-help.nvim",
    keys = {
      {
        "<leader>wt",
        function()
          require("floating-help").toggle()
        end,
        desc = "Toggle floating help",
      },
    },
    config = function()
      local custom_border = require("lib.icons").custom_border
      require("floating-help").setup({
        width = 0.8,
        height = 0.9,
        position = "C",
        border = custom_border,
      })
    end,
  },
}
