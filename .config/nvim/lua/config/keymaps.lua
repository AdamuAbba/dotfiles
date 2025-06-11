-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set
local del = vim.keymap.del

--============================================= Delete default keymaps =============================================
del("n", "<leader>E")

---- lazygit defaults
del("n", "<leader>gg")
del("n", "<leader>gG")

--============================================= deactivate defaults =============================================
------ Deactive Direction keys
map({ "n", "i", "v" }, "<Up>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Down>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Left>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Right>", "<NOP>", { noremap = true })
map({ "n", "v" }, "<C-g>", "<NOP>", { noremap = true })
------ Deactive macro recording
map({ "n", "v" }, "q", "<NOP>", { noremap = true })

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

--============================================= Yank Line + Diagnostic (maodified to yank just diagnostic) ===========
map("n", "yd", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line_num = pos[1] - 1 -- 0-indexed
  local line_text = vim.api.nvim_buf_get_lines(0, line_num, line_num + 1, false)[1]
  local diagnostics = vim.diagnostic.get(0, { lnum = line_num })
  if #diagnostics == 0 then
    vim.notify("No diagnostic found on this line", vim.log.levels.WARN)
    return
  end
  local message_lines = {}
  for _, d in ipairs(diagnostics) do
    for msg_line in d.message:gmatch("[^\n]+") do
      table.insert(message_lines, msg_line)
    end
  end
  local formatted = {}
  -- table.insert(formatted, "Line:\n" .. line_text .. "\n")
  -- table.insert(formatted, "Diagnostic on that line:\n" .. table.concat(message_lines, "\n"))
  table.insert(formatted, table.concat(message_lines, "\n"))
  vim.fn.setreg("+", table.concat(formatted, "\n\n"))
  vim.notify("Line and diagnostic copied to clipboard", vim.log.levels.INFO)
end, { desc = "Yank line and diagnostic to system clipboard" })

--============================================= goto-preview =============================================
map(
  "n",
  "qpd",
  "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
  { desc = "Preview definition", noremap = true }
)

map(
  "n",
  "qpc",
  "<cmd>lua require('goto-preview').close_all_win()<CR>",
  { desc = "Close preview windows", noremap = true }
)

map(
  "n",
  "qpt",
  "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
  { desc = "Preview type definition", noremap = true }
)

--============================================= lazygit (Zellij pane) =============================================

local function open_lazygit_in_zellij()
  vim.fn.jobstart({
    "zellij",
    "run",
    "--name",
    "LazyGit",
    "--floating",
    "--height=98%",
    "--width=95%",
    "--x=3%",
    "--y=3%",
    "--",
    "zsh",
    "-ic",
    "lazygit && zellij action close-pane",
  }, { detach = true })
end

map("n", "<leader>gg", open_lazygit_in_zellij, { desc = "Lazygit (Zellij pane)" })
