--============================================= TODO Picker =============================================
vim.keymap.set("n", "<leader>st", function()
  local cmd = [[rg --vimgrep --hidden --glob '!.git' '\bTODO:' .]]
  local lines = vim.fn.systemlist(cmd)
  local exit_code = vim.v.shell_error

  if exit_code > 1 then
    vim.notify(table.concat(lines, "\n"), vim.log.levels.ERROR)
    return
  end

  vim.fn.setqflist({}, "r", {
    title = "TODO matches",
    lines = lines,
    efm = "%f:%l:%c:%m",
  })

  if #lines == 0 then
    vim.notify("No TODO matches", vim.log.levels.INFO)
    vim.cmd("cclose")
    return
  end

  vim.cmd("copen 16")
end, { desc = "Search TODOs" })

--============================================= Word Grep =============================================
local function grep_to_qflist(pattern, whole_word)
  if pattern == "" then
    vim.notify("No word under cursor", vim.log.levels.WARN)
    return
  end

  local cmd = { "rg", "--vimgrep", "--hidden", "--glob", "!.git", "--fixed-strings" }
  if whole_word then
    table.insert(cmd, "--word-regexp")
  end
  table.insert(cmd, "--")
  table.insert(cmd, pattern)

  local result = vim.system(cmd, { text = true, cwd = vim.uv.cwd() }):wait()

  if result.code > 1 then
    vim.notify(result.stderr, vim.log.levels.ERROR)
    return
  end

  local lines = vim.split(result.stdout or "", "\n", { trimempty = true })

  vim.fn.setqflist({}, "r", {
    title = "Grep: " .. pattern,
    lines = lines,
    efm = "%f:%l:%c:%m",
  })

  if #lines == 0 then
    vim.notify("No matches for " .. pattern, vim.log.levels.INFO)
    vim.cmd("cclose")
    return
  end

  vim.cmd("copen 16")
end

vim.keymap.set("n", "<leader>sw", function()
  grep_to_qflist(vim.fn.expand("<cword>"), true)
end, { desc = "Grep word under cursor" })

vim.keymap.set("x", "<leader>sw", function()
  local region = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
  grep_to_qflist(region[1] or "", false)
end, { desc = "Grep selection" })

--============================================= File Picker =============================================
local filescache = {}
local cache_cwd = nil

local function get_files()
  local cwd = vim.uv.cwd()

  if cache_cwd == cwd and not vim.tbl_isempty(filescache) then
    return filescache
  end

  local result = vim
    .system({
      "rg",
      "--files",
      "--hidden",
      "--glob",
      "!.git",
      "--no-config",
    }, {
      text = true,
      cwd = cwd,
    })
    :wait()

  if result.code ~= 0 then
    filescache = {}
    cache_cwd = cwd
    return filescache
  end

  filescache = vim.split(result.stdout, "\n", { trimempty = true })
  cache_cwd = cwd
  return filescache
end

_G.__cmdline_fuzzy_find = function(arg)
  if arg:match("^%s*$") then
    return {}
  end

  local files = get_files()
  return vim.fn.matchfuzzy(files, arg)
end

vim.opt.findfunc = "v:lua.__cmdline_fuzzy_find"

vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    if vim.fn.getcmdtype() == ":" then
      filescache = {}
      cache_cwd = nil
    end
  end,
})

vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Pick File" })

--============================================= Buffer Picker =============================================
vim.keymap.set("n", "<leader>fb", ":buffer ", { desc = "Pick Buffer" })

--============================================= Help File Picker =============================================
vim.keymap.set("n", "<leader>sh", ":help ", { desc = "Help File" })

vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function()
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = true, silent = true, nowait = true })
  end,
})

--============================================= History Picker =============================================
vim.keymap.set("n", "<leader>sc", "q:", { desc = "Command History" })
vim.keymap.set("n", "<leader>s/", "q/", { desc = "Search History" })
