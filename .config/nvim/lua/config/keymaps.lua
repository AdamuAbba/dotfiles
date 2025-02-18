-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set
local del = vim.keymap.del

--============================================= Delete default keymaps =============================================
del("n", "<leader>E")
map({ "n", "i", "v" }, "<Up>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Down>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Left>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Right>", "<NOP>", { noremap = true })

--============================================= Open URL =============================================
local open_command = "xdg-open"
if vim.fn.has("mac") == 1 then
  open_command = "open"
end

local function url_repo()
  local cursorword = vim.fn.expand("<cfile>")
  if string.find(cursorword, "^[a-zA-Z0-9-_.]*/[a-zA-Z0-9-_.]*$") then
    cursorword = "https://github.com/" .. cursorword
  end
  return cursorword or ""
end

map("n", "gl", function()
  vim.fn.jobstart({ open_command, url_repo() }, { detach = true })
end, {
  desc = " Open link under cursor",
  silent = true,
})

--============================================= Create Blank Newline =============================================
map("n", "<leader>o", "o<ESC>k", { desc = "↓ Create Blank Newline below and stay in Normal mode", silent = true })
map("n", "<leader>O", "o<ESC>j", { desc = "↑ Create Blank Newline above and stay in Normal mode", silent = true })

--============================================= nvim-scissors =============================================
map("n", "<leader>he", function()
  require("scissors").editSnippet()
end, { desc = "Snippet: Edit" })

-- when used in visual mode, prefills the selection as snippet body
map({ "n", "x" }, "<leader>ha", function()
  require("scissors").addNewSnippet()
end, { desc = "Snippet: Add" })
