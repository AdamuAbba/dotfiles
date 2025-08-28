return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = "40%",
            col = "50%",
          },
        },
      },
      presets = {
        lsp_doc_border = true,
        bottom_search = false,
      },
    },
  },
}
