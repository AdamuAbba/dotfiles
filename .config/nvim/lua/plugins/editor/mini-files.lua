return {
  {
    "nvim-mini/mini.files",
    lazy = false,
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        use_as_default_explorer = true,
        permanent_delete = false,
      })
      return opts
    end,
  },
}
