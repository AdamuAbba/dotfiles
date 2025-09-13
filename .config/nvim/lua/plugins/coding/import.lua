return {
  {
    "piersolenski/import.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      picker = "snacks",
      insert_at_top = true,
    },
    keys = {
      {
        "<leader>ci",
        function()
          require("import").pick()
        end,
        desc = "Import",
      },
    },
  },
}
