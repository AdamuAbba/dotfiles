return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "zenbones",
        callback = function()
          require("config.highlight-overrides"):apply()
        end,
      })
    end,
  },
}
