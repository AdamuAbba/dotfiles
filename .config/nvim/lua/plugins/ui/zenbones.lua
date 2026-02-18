return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "zenbones",
        callback = function()
          require("lib.highlight-overrides"):apply()
        end,
      })
    end,
  },
}
