return {
  {
    "danymat/neogen",
    dependencies = {
      "nvim-mini/mini.snippets",
    },
    cmd = "Neogen",
    opts = function(_, opts)
      opts.snippet_engine = "nvim"
      opts.enabled = true
      opts.input_after_comment = true
    end,
    config = function(_, opts)
      require("neogen").setup(opts)
    end,
  },
}
