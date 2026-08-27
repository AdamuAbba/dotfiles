return {
  {
    "brianhuster/live-preview.nvim",
    keys = {
      {
        "<leader>cp",
        "<cmd>LivePreview start<CR>",
        desc = "live preview",
        silent = true,
        mode = { "n" },
        ft = "markdown",
      },
    },
    config = function()
      require("livepreview.config").set({
        port = 5500,
        browser = "default",
        dynamic_root = false,
        sync_scroll = true,
        picker = "vim.ui.select",
        address = "127.0.0.1",
      })
    end,
  },
}
