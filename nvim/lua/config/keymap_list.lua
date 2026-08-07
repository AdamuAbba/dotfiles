local function keymap_list()
  local keymaps = vim.api.nvim_exec2("map", { output = true }).output
  local lines = vim.split(keymaps, "\n")

  local buff = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buff, 0, -1, false, lines)
  vim.bo[buff].modifiable = false
  vim.bo[buff].bufhidden = "wipe"

  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.6)

  local win = vim.api.nvim_open_win(buff, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor(vim.o.lines - 1),
    col = 0,
    style = "minimal",
    anchor = "SW",
    border = "rounded",
    title = " Keymaps ",
    title_pos = "left",
  })

  local opts = { buffer = buff, nowait = true, silent = true }
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, opts)
  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end, opts)
end

vim.keymap.set("n", "<leader>sk", keymap_list, { desc = "keymaps" })
