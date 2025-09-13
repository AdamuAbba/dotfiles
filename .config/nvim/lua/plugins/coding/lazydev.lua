return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = function(_, opts)
      opts.library = vim.list_extend(opts.library or {}, {
        { path = "wezterm-types", mods = { "wezterm" } },
      })
      return opts
    end,
  },
}
