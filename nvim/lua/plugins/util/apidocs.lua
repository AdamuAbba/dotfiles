return {
  "emmanueltouzery/apidocs.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = { "ApidocsSearch", "ApidocsInstall", "ApidocsOpen", "ApidocsSelect", "ApidocsUninstall" },
  config = function(_, opts)
    local apidocs = require("apidocs")
    opts.picker = "ui_select"
    apidocs.setup(opts)
    local langs = { "lua~5.4", "hammerspoon", "rust", "react", "react_native", "typescript", "javascript", "cpp" }
    apidocs.ensure_install(langs)
  end,
  keys = {
    {
      "<leader>fd",
      function()
        require("apidocs").apidocs_open({
          restrict_sources = { "lua~5.4", "hammerspoon" },
        })
      end,
      desc = "Open Lua/hs docs",
      ft = "lua",
    },
    {
      "<leader>fd",
      function()
        require("apidocs").apidocs_open({
          restrict_sources = { "rust" },
        })
      end,
      desc = "Open rust docs",
      ft = "rust",
    },
    {
      "<leader>fd",
      function()
        require("apidocs").apidocs_open({
          restrict_sources = { "react_native" },
        })
      end,
      desc = "Open react-native docs",
      ft = { "typescriptreact", "javascriptreact" },
    },
    {
      "<leader>fd",
      function()
        require("apidocs").apidocs_open({
          restrict_sources = { "cpp" },
        })
      end,
      desc = "Open cpp docs",
      ft = { "cpp" },
    },
  },
}
