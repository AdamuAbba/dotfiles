return {
  {
    "zbirenbaum/copilot.lua",
    opts = function(_, opts)
      opts.suggestion = vim.tbl_deep_extend("force", opts.suggestion or {}, {
        keymap = {
          accept = "<M-]>",
          next = false,
          prev = false,
        },
      })
    end,
  },
}
