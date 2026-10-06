local wk = require("which-key")
local map = vim.keymap.set
local del = vim.keymap.del

----- window
wk.add({
  { "<leader>wb", "<C-W>s", desc = "Split Window Below", remap = true },
  { "<leader>wr", "<C-W>v", desc = "Split Window Right", remap = true },
})

---- buffer
wk.add({
  { mode = "n", "<leader>bd", "<cmd>:bd<cr>", desc = "Delete Buffer" },
})

wk.add({
  {
    "<leader>sq",
    function()
      vim.cmd("copen 16")
    end,
    desc = "Quickfix List",
  },
})

--============================================= Neovim defaults I don't want =============================================
del("i", "<Tab>") -- vim.snippet jump
del("n", "[b")
del("n", "]b")

--============================================= Editing defaults (formerly LazyVim's) =============================================
------ move by display line on wrapped text, unless given a count
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

------ resize window
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

------ clear search highlight on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

------ n always searches forward and N backward; zv opens folds at the match
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

------ undo break-points while typing
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

------ keep the selection after indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

------ comments
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

------ files / windows
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

------ format (conform, falling back to the LSP formatter)
map({ "n", "x" }, "<leader>cf", function()
  local ok, conform = pcall(require, "conform")
  if not ok then
    vim.notify("conform.nvim isn't installed in this mode yet", vim.log.levels.WARN)
    return
  end
  conform.format({ lsp_format = "fallback" })
end, { desc = "Format" })

------ diagnostics (Neovim's own ]d/[d don't open the float)
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = vim.v.count1, float = true })
end, { desc = "Next Diagnostic" })
map("n", "[d", function()
  vim.diagnostic.jump({ count = -vim.v.count1, float = true })
end, { desc = "Prev Diagnostic" })
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
  { "<leader>m", "<cmd>messages<cr>", desc = "Show messages" },
})

--============================================= Yank Line + Diagnostic (modified to yank just diagnostic) ===========
map("n", "yd", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line_num = pos[1] - 1 -- 0-indexed
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
    vim.notify(name .. " made executable", vim.log.levels.INFO)
  else
    vim.notify("Failed to chmod " .. name, vim.log.levels.ERROR)
  end
end

wk.add({
  { "<leader>fx", make_file_executable, desc = "Make file executable", mode = { "n" } },
})
