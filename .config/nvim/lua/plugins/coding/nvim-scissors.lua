return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = function(_, opts)
      ---@type "yq"|"jq"|"none"|string[]
      opts.jsonFormatter = "jq"
      opts.backdrop = vim.tbl_deep_extend("force", opts.backdrop or {}, {
        enabled = false,
        blend = 0,
      })
      return opts
    end,
    config = true,
  },
}
