vim.pack.add({ "https://github.com/brianhuster/live-preview.nvim" })

require("livepreview.config").set({
  port = 5500,
  browser = "default",
  dynamic_root = false,
  sync_scroll = true,
  picker = "vim.ui.select",
  address = "127.0.0.1",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("live_preview_keys", { clear = true }),
  pattern = "markdown",
  callback = function(ev)
    vim.keymap.set("n", "<leader>cp", "<cmd>LivePreview start<CR>", { buffer = ev.buf, desc = "live preview" })
  end,
})
