return {
  {
    "brianhuster/live-preview.nvim",
    dependencies = {
      "nvim-mini/mini.pick",
    },
    config = function()
      local wk = require("which-key")
      require("livepreview.config").set({
        port = 5500,
        browser = "default",
        dynamic_root = false,
        sync_scroll = true,
        picker = "mini.pick",
        address = "127.0.0.1",
      })

      wk.add({
        {
          "<leader>cp",
          "<cmd>LivePreview start<CR>",
          desc = "live preview",
          silent = true,
          mode = { "n" },
          cond = function()
            return vim.bo.filetype == "markdown"
          end,
        },
      })
    end,
  },
}
