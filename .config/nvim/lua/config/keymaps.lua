-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local wk = require("which-key")
local map = vim.keymap.set
-- local del = vim.keymap.del

--============================================= deactivate defaults =============================================
------ Deactive Direction keys
map({ "n", "i", "v" }, "<Up>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Down>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Left>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Right>", "<NOP>", { noremap = true })
map({ "n", "v" }, "<C-g>", "<NOP>", { noremap = true })

map("n", "<C-l>", function()
  local cur_win = vim.api.nvim_get_current_win()
  local cur_ft = vim.bo[vim.api.nvim_win_get_buf(cur_win)].filetype

  local priorities = { "codecompanion", "snacks_picker_list" }

  for _, ft in ipairs(priorities) do
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local wft = vim.bo[buf].filetype
      local cfg = vim.api.nvim_win_get_config(win)

      -- skip current window's filetype so you can "advance"
      if cfg.relative ~= "" and wft == ft and wft ~= cur_ft then
        vim.api.nvim_set_current_win(win)
        return
      end
    end
  end

  -- fallback: try normal right split
  pcall(function()
    vim.cmd("wincmd l")
  end)
end, { desc = "Go to right float or window", silent = true, noremap = true })
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

map("n", "<leader>fx", make_file_executable, { desc = " Make file executable" })
--============================================= goto-preview =============================================
local go_to_preview = require("goto-preview")

wk.add({
  { "gb", group = " Goto Preview", mode = { "n" } },
  { "gbd", go_to_preview.goto_preview_definition, desc = "󰈔 Preview Definition" },
  { "gbq", go_to_preview.close_all_win, desc = " Close Preview Windows" },
  {
    "gbt",
    go_to_preview.goto_preview_type_definition,
    desc = "󰙅 Preview Type Definition",
  },
})
