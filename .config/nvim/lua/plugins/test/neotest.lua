return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "mrcjkb/rustaceanvim",
    },
    opts = function(_, opts)
      opts.adapters = vim.tbl_deep_extend("force", opts.adapters or {}, {
        ["rustaceanvim.neotest"] = {},
        ["neotest-vitest"] = {},
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      })
    end,
  },
}
