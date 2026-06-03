return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-jest",
      "mrcjkb/rustaceanvim",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "orjangj/neotest-ctest",
    },
    opts = function(_, opts)
      local custom_border = require("lib.icons").custom_border
      opts.adapters = vim.tbl_deep_extend("force", opts.adapters or {}, {
        require("neotest-ctest").setup({
          extra_args = {
            "--test-dir build",
            "--output-on-failure",
          },
        }),
        ["rustaceanvim.neotest"] = {},
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      })
      opts.floating = vim.tbl_deep_extend("force", opts.floating or {}, {
        border = custom_border,
        max_height = 0.7,
        max_width = 0.6,
        options = {}
      })
      opts.output = {
        open_on_run = true
      }
      opts.quickfix = {
        enabled = false,
        open = false,
      }
    end,
  },
}
