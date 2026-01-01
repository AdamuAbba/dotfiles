-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local wk = require("which-key")
local map = vim.keymap.set
local del = vim.keymap.del
local icons = require("lib.icons")

del("n", "<leader>fT")
--============================================= deactivate defaults =============================================
------ Deactive Direction keys
map({ "n", "i", "v" }, "<Up>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Down>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Left>", "<NOP>", { noremap = true })
map({ "n", "i", "v" }, "<Right>", "<NOP>", { noremap = true })
map({ "n", "v" }, "<C-g>", "<NOP>", { noremap = true })

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
    icon = " ",
    desc = "Open link under cursor",
    silent = true,
    mode = { "n" },
  },
})

--============================================= Create Blank Newline =============================================
wk.add({
  { "<leader>o", group = "Add Blank Line", icon = " ", mode = { "n" } },
  { "<leader>oj", "o<ESC>k", desc = "Blank Newline below", icon = "↓" },
  { "<leader>ok", "O<ESC>j", desc = "Blank Newline above", icon = "↑" },
})

--============================================= nvim-scissors =============================================
local Scissors = require("scissors")

wk.add({
  { "<leader>h", group = "scissors", icon = icons.ui.Scissors, mode = { "n" } },
  {
    "<leader>he",
    function()
      Scissors.editSnippet()
    end,
    desc = "Edit snippet",
    icon = icons.ui.Edit,
  },
  {
    "<leader>ha",
    function()
      Scissors.addNewSnippet()
    end,
    desc = "Add new snippet",
    icon = icons.ui.AddAlt,
    mode = { "n", "x" },
  },
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
  { "<leader>fx", make_file_executable, icon = "", desc = "Make file executable", mode = { "n" } },
})
--============================================= user commands =============================================
vim.api.nvim_create_user_command("LazySpec", function(opts)
  local plugin = opts.args
  local spec = require("lazy.core.config").plugins[plugin]
  if not spec then
    vim.notify("No plugin spec found for " .. plugin, vim.log.levels.ERROR)
    return
  end

  -- scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("filetype", "lua", { buf = buf })

  local lines = vim.split(vim.inspect(spec), "\n")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- floating win
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 0.90),
    height = math.floor(vim.o.lines * 0.90),
    row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.90)) / 2) - 1,
    col = math.floor((vim.o.columns - math.floor(vim.o.columns * 0.90)) / 2),
    style = "minimal",
    border = "rounded",
    title = "LazySpec",
    title_pos = "center",
  })

  -- map q to close
  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true, silent = true })
end, {
  nargs = 1,
  complete = function(_, _)
    return vim.tbl_keys(require("lazy.core.config").plugins)
  end,
})

--======================================== get the focused win highlight groups ===========================================
--  user command to get the focused win highlight groups
vim.api.nvim_create_user_command("GetFocusedWinHL", function()
  local win = vim.api.nvim_get_current_win()
  local hl_str = vim.api.nvim_get_option_value("winhighlight", { win = win })

  local lines = {}
  if hl_str == "" then
    table.insert(lines, "No winhighlight overrides set")
  else
    for from, to in string.gmatch(hl_str, "(%w+):(%w+)") do
      local id = vim.api.nvim_get_hl_id_by_name(to)
      local hl = vim.api.nvim_get_hl(0, { id = id })

      table.insert(lines, from .. " -> " .. to)

      -- split vim.inspect output into lines
      for s in vim.inspect(hl):gmatch("[^\n]+") do
        table.insert(lines, "  " .. s)
      end

      table.insert(lines, "")
    end
  end

  -- always create a new scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- open floating window
  local width = math.floor(vim.o.columns * 0.5)
  local height = math.floor(vim.o.lines * 0.5)

  local float_win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = "WinHighlight",
    title_pos = "center",
  })

  -- add 'q' to close
  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(float_win) then
      vim.api.nvim_win_close(float_win, true)
    end
  end, { buffer = buf, nowait = true, noremap = true, silent = true })
end, {})

--============================================= markdown task manager stuff =============================================
-- Copied and tweaked a little bit from Linkarzu's Neobean config (DUDE IS A FREAKING LEGEND 🔥)
-- https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/config/keymaps.lua
-- His youtube tutorial => https://www.youtube.com/watch?v=SXKsIyYJIrU
-- Toggle bullet point at the beginning of the current line in normal mode
-- If in a multiline paragraph, make sure the cursor is on the line at the top
-- "d" is for "dash" lamw25wmal
vim.keymap.set("n", "<leader>md", function()
  -- Get the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_buffer = vim.api.nvim_get_current_buf()
  local start_row = cursor_pos[1] - 1
  local col = cursor_pos[2]
  -- Get the current line
  local line = vim.api.nvim_buf_get_lines(current_buffer, start_row, start_row + 1, false)[1]
  -- Check if the line already starts with a bullet point
  if line:match("^%s*%-") then
    -- Remove the bullet point from the start of the line
    line = line:gsub("^%s*%-", "")
    vim.api.nvim_buf_set_lines(current_buffer, start_row, start_row + 1, false, { line })
    return
  end
  -- Search for newline to the left of the cursor position
  local left_text = line:sub(1, col)
  local bullet_start = left_text:reverse():find("\n")
  if bullet_start then
    bullet_start = col - bullet_start
  end
  -- Search for newline to the right of the cursor position and in following lines
  local right_text = line:sub(col + 1)
  local bullet_end = right_text:find("\n")
  local end_row = start_row
  while not bullet_end and end_row < vim.api.nvim_buf_line_count(current_buffer) - 1 do
    end_row = end_row + 1
    local next_line = vim.api.nvim_buf_get_lines(current_buffer, end_row, end_row + 1, false)[1]
    if next_line == "" then
      break
    end
    right_text = right_text .. "\n" .. next_line
    bullet_end = right_text:find("\n")
  end
  if bullet_end then
    bullet_end = col + bullet_end
  end
  -- Extract lines
  local text_lines = vim.api.nvim_buf_get_lines(current_buffer, start_row, end_row + 1, false)
  local text = table.concat(text_lines, "\n")
  -- Add bullet point at the start of the text
  local new_text = "- " .. text
  local new_lines = vim.split(new_text, "\n")
  -- Set new lines in buffer
  vim.api.nvim_buf_set_lines(current_buffer, start_row, end_row + 1, false, new_lines)
end, { desc = "[P]Toggle bullet point (dash)" })

-- HACK: Manage Markdown tasks in Neovim similar to Obsidian | Telescope to List Completed and Pending Tasks
-- https://youtu.be/59hvZl077hM
--
-- If there is no `untoggled` or `done` label on an item, mark it as done
-- and move it to the "## completed tasks" markdown heading in the same file, if
-- the heading does not exist, it will be created, if it exists, items will be
-- appended to it at the top lamw25wmal
--
-- If an item is moved to that heading, it will be added the `done` label
vim.keymap.set("n", "<leader>mx", function()
  -- Customizable variables
  -- NOTE: Customize the completion label
  local label_done = "done:"
  -- NOTE: Customize the timestamp format
  local timestamp = os.date("%Y-%m-%d %-I:%M:%S %p")
  -- local timestamp = os.date("%y%m%d")
  -- NOTE: Customize the heading and its level
  local tasks_heading = "## Completed tasks"
  -- Save the view to preserve folds
  vim.cmd("mkview")
  local api = vim.api
  -- Retrieve buffer & lines
  local buf = api.nvim_get_current_buf()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local start_line = cursor_pos[1] - 1
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local total_lines = #lines
  -- If cursor is beyond last line, do nothing
  if start_line >= total_lines then
    vim.cmd("loadview")
    return
  end
  ------------------------------------------------------------------------------
  -- (A) Move upwards to find the bullet line (if user is somewhere in the chunk)
  ------------------------------------------------------------------------------
  while start_line > 0 do
    local line_text = lines[start_line + 1]
    -- Stop if we find a blank line or a bullet line
    if line_text == "" or line_text:match("^%s*%-") then
      break
    end
    start_line = start_line - 1
  end
  -- Now we might be on a blank line or a bullet line
  if lines[start_line + 1] == "" and start_line < (total_lines - 1) then
    start_line = start_line + 1
  end
  ------------------------------------------------------------------------------
  -- (B) Validate that it's actually a task bullet, i.e. '- [ ]' or '- [x]'
  ------------------------------------------------------------------------------
  local bullet_line = lines[start_line + 1]
  if not bullet_line:match("^%s*%- %[[x ]%]") then
    -- Not a task bullet => show a message and return
    print("Not a task bullet: no action taken.")
    vim.cmd("loadview")
    return
  end
  ------------------------------------------------------------------------------
  -- 1. Identify the chunk boundaries
  ------------------------------------------------------------------------------
  local chunk_start = start_line
  local chunk_end = start_line
  while chunk_end + 1 < total_lines do
    local next_line = lines[chunk_end + 2]
    if next_line == "" or next_line:match("^%s*%-") then
      break
    end
    chunk_end = chunk_end + 1
  end
  -- Collect the chunk lines
  local chunk = {}
  for i = chunk_start, chunk_end do
    table.insert(chunk, lines[i + 1])
  end
  ------------------------------------------------------------------------------
  -- 2. Check if chunk has [done: ...] or [untoggled], then transform them
  ------------------------------------------------------------------------------
  local has_done_index = nil
  local has_untoggled_index = nil
  for i, line in ipairs(chunk) do
    -- Replace `[done: ...]` -> `` `done: ...` ``
    chunk[i] = line:gsub("%[done:([^%]]+)%]", "`" .. label_done .. "%1`")
    -- Replace `[untoggled]` -> `` `untoggled` ``
    chunk[i] = chunk[i]:gsub("%[untoggled%]", "`untoggled`")
    if chunk[i]:match("`" .. label_done .. ".-`") then
      has_done_index = i
      break
    end
  end
  if not has_done_index then
    for i, line in ipairs(chunk) do
      if line:match("`untoggled`") then
        has_untoggled_index = i
        break
      end
    end
  end
  ------------------------------------------------------------------------------
  -- 3. Helpers to toggle bullet
  ------------------------------------------------------------------------------
  -- Convert '- [ ]' to '- [x]'
  local function bulletToX(line)
    return line:gsub("^(%s*%- )%[%s*%]", "%1[x]")
  end
  -- Convert '- [x]' to '- [ ]'
  local function bulletToBlank(line)
    return line:gsub("^(%s*%- )%[x%]", "%1[ ]")
  end
  ------------------------------------------------------------------------------
  -- 4. Insert or remove label *after* the bracket
  ------------------------------------------------------------------------------
  local function insertLabelAfterBracket(line, label)
    local prefix = line:match("^(%s*%- %[[x ]%])")
    if not prefix then
      return line
    end
    local rest = line:sub(#prefix + 1)
    return prefix .. " " .. label .. rest
  end
  local function removeLabel(line)
    -- If there's a label (like `` `done: ...` `` or `` `untoggled` ``) right after
    -- '- [x]' or '- [ ]', remove it
    return line:gsub("^(%s*%- %[[x ]%])%s+`.-`", "%1")
  end
  ------------------------------------------------------------------------------
  -- 5. Update the buffer with new chunk lines (in place)
  ------------------------------------------------------------------------------
  local function updateBufferWithChunk(new_chunk)
    for idx = chunk_start, chunk_end do
      lines[idx + 1] = new_chunk[idx - chunk_start + 1]
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end
  ------------------------------------------------------------------------------
  -- 6. Main toggle logic
  ------------------------------------------------------------------------------
  if has_done_index then
    chunk[has_done_index] = removeLabel(chunk[has_done_index]):gsub("`" .. label_done .. ".-`", "`untoggled`")
    chunk[1] = bulletToBlank(chunk[1])
    chunk[1] = removeLabel(chunk[1])
    chunk[1] = insertLabelAfterBracket(chunk[1], "`untoggled`")
    updateBufferWithChunk(chunk)
    vim.notify("Untoggled", vim.log.levels.INFO)
  elseif has_untoggled_index then
    chunk[has_untoggled_index] =
      removeLabel(chunk[has_untoggled_index]):gsub("`untoggled`", "`" .. label_done .. " " .. timestamp .. "`")
    chunk[1] = bulletToX(chunk[1])
    chunk[1] = removeLabel(chunk[1])
    chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")
    updateBufferWithChunk(chunk)
    vim.notify("Completed", vim.log.levels.INFO)
  else
    -- Save original window view before modifications
    local win = api.nvim_get_current_win()
    local view = api.nvim_win_call(win, function()
      return vim.fn.winsaveview()
    end)
    chunk[1] = bulletToX(chunk[1])
    chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")
    -- Remove chunk from the original lines
    for i = chunk_end, chunk_start, -1 do
      table.remove(lines, i + 1)
    end
    -- Append chunk under 'tasks_heading'
    local heading_index = nil
    for i, line in ipairs(lines) do
      if line:match("^" .. tasks_heading) then
        heading_index = i
        break
      end
    end
    if heading_index then
      for _, cLine in ipairs(chunk) do
        table.insert(lines, heading_index + 1, cLine)
        heading_index = heading_index + 1
      end
      -- Remove any blank line right after newly inserted chunk
      local after_last_item = heading_index + 1
      if lines[after_last_item] == "" then
        table.remove(lines, after_last_item)
      end
    else
      table.insert(lines, tasks_heading)
      for _, cLine in ipairs(chunk) do
        table.insert(lines, cLine)
      end
      local after_last_item = #lines + 1
      if lines[after_last_item] == "" then
        table.remove(lines, after_last_item)
      end
    end
    -- Update buffer content
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.notify("Completed", vim.log.levels.INFO)
    -- Restore window view to preserve scroll position
    api.nvim_win_call(win, function()
      vim.fn.winrestview(view)
    end)
  end
  -- Write changes and restore view to preserve folds
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  vim.cmd("loadview")
end, { desc = "[P]Toggle task and move it to 'done'" })

-- create new task file by date or open existing one
local tasks_dir = "/Users/abba/Documents/shytypes-obs-vault/tasks"

local function new_task_by_date()
  ---@diagnostic disable-next-line: undefined-field
  if vim.loop.fs_stat(tasks_dir) == nil then
    vim.notify("Tasks directory not found: " .. tasks_dir, vim.log.levels.ERROR)
    return
  end

  local date = os.date("%Y-%m-%d-%A"):lower()
  local filename = tasks_dir .. "/" .. date .. ".md"

  if vim.loop.fs_stat(filename) == nil then
    local title = "Daily Tasks"
    local datetime = os.date("%Y-%m-%d %-I:%M:%S %p")
    local lines = {
      "---",
      "title: " .. title,
      'date: "' .. datetime .. '"',
      "tags:",
      "  - daily-tasks",
      "---",
      "",
      "## Uncompleted Tasks",
      "",
      "- [ ] first task",
      "",
      "## Completed tasks",
    }
    vim.fn.writefile(lines, filename)
  end

  vim.cmd("edit " .. vim.fn.fnameescape(filename))
end

wk.add({
  { "<leader>m", group = "Tasks", icon = icons.ui.Task, mode = { "n" } },
  {
    "<leader>mn",
    new_task_by_date,
    desc = "New/Open task by date",
    icon = icons.ui.AddAlt,
  },
})

--============================================= open picker =============================================
vim.api.nvim_create_user_command("SnacksFilePicker", function()
  local ok, snacks = pcall(require, "snacks")
  if not ok then
    return
  end
  snacks.picker("files", { root = false, layout = "select_with_preview" })
end, { nargs = 0 })
