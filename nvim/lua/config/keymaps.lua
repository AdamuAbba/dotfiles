-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local wk = require("which-key")
local map = vim.keymap.set
local del = vim.keymap.del

--============================================= Lazy defaults =============================================
------ terminal defaults
del("n", "<leader>fT")
del("n", "<leader>ft")
del("n", "<c-/>")
del("n", "<c-_>")

------ Git
del("n", "<leader>gb")
del("n", "<leader>gB")
del("n", "<leader>gl")
del("n", "<leader>gL")
del("n", "<leader>gY")
del("n", "<leader>gf")
del("i", "<Tab>")

------ Snacks Toggle module
del("n", "<leader>uf")
del("n", "<leader>uF")
-- del("n", "<leader>uG")
del("n", "<leader>ug")
del("n", "<leader>uh")
del("n", "<leader>uz")
del("n", "<leader>uZ")
del("n", "<leader>ui")
del("n", "<leader>uI")
del("n", "<leader>up")
del("n", "<leader>ur")
del("n", "<leader>us")
del("n", "<leader>uS")
del("n", "<leader>uL")
del("n", "<leader>ul")
del("n", "<leader>ud")
del("n", "<leader>uD")
del("n", "<leader>uc")
del("n", "<leader>uA")
del("n", "<leader>ua")
del("n", "<leader>uT")
del("n", "<leader>ub")
del("n", "<leader>uw")

------ quit/sessions

------ diagnostics/quickfix
del("n", "<leader>xl")
del("n", "<leader>xq")
del("n", "]e")
del("n", "[e")
del("n", "]w")
del("n", "[w")

------ tabs
del("n", "<leader><tab>l")
del("n", "<leader><tab>o")
del("n", "<leader><tab>f")
del("n", "<leader><tab><tab>")
del("n", "<leader><tab>]")
del("n", "<leader><tab>d")
del("n", "<leader><tab>[")

------ keywordprg
del("n", "<leader>K")

------ lazy
del("n", "<leader>l")
del("n", "<leader>L")

wk.add({
  { "<leader>l", group = "Lazy", mode = { "n" } },
  { "<leader>ll", "<cmd>Lazy<cr>", desc = "Plugin manager" },
  {
    "<leader>lc",
    function()
      LazyVim.news.changelog()
    end,
    desc = "LazyVim Changelog",
  },
})

----- window
del("n", "<leader>-")
del("n", "<leader>|")

wk.add({
  { "<leader>wb", "<C-W>s", desc = "Split Window Below", remap = true },
  { "<leader>wr", "<C-W>v", desc = "Split Window Right", remap = true },
})

---- buffer
del("n", "[b")
del("n", "]b")
del("n", "<leader>bb")
del("n", "<leader>`")
del("n", "<leader>bD")
del("n", "<leader>bd")

wk.add({
  { mode = "n", "<leader>bd", "<cmd>:bd<cr>", desc = "Delete Buffer" },
})
--============================================= deactivate defaults =============================================
------ Deactive Direction keys
map({ "n", "i", "v" }, "<Up>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Down>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Left>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Right>", "<NOP>", { noremap = true })
map({ "n", "v" }, "<C-g>", "<NOP>", { noremap = true })
map({ "n", "v" }, "q", "<NOP>", { noremap = true })

--- accept completion with <CR> in insert mode
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return vim.api.nvim_replace_termcodes("<C-y>", true, false, true)
  end
  return "\n"
end, { expr = true })

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

wk.add({
  {
    "gl",
    function()
      vim.fn.jobstart({ open_command, url_repo() }, { detach = true })
    end,
    desc = "Open repo url",
    silent = true,
    mode = { "n" },
  },
})
--============================================= Create Blank Newline =============================================
wk.add({
  { "<leader>o", group = "Add Blank Line", mode = { "n" } },
  { "<leader>oj", "o<ESC>k", desc = "Blank Newline below" },
  { "<leader>ok", "O<ESC>j", desc = "Blank Newline above" },
})

--============================================= Nvim Built-ins =============================================
wk.add({
  { "<leader>m", "<cmd>messages<cr>", desc = "Show :messages" },
})

--============================================= Yank Line + Diagnostic (maodified to yank just diagnostic) ===========
map("n", "yd", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line_num = pos[1] - 1 -- 0-indexed
  ---@diagnostic disable-next-line: unused-local
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

--============================================= Make file executable =============================================
local function make_file_executable()
  local file = vim.fn.expand("%:p")
  local name = vim.fn.expand("%:t")

  if file == "" then
    vim.notify("No file loaded", vim.log.levels.ERROR)
    return
  end

  local ok = os.execute("chmod +x " .. vim.fn.shellescape(file))
  if ok then
    vim.notify("  " .. name .. " made executable", vim.log.levels.INFO)
  else
    vim.notify("  Failed to chmod " .. name, vim.log.levels.ERROR)
  end
end

wk.add({
  { "<leader>fx", make_file_executable, desc = "Make file executable", mode = { "n" } },
})
