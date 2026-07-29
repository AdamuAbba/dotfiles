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
