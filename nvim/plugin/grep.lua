vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
vim.opt.grepformat = "%f:%l:%c:%m"

--============================================= Prompt Grep =============================================
local function grep_to_qflist(pattern)
  if not pattern or vim.trim(pattern) == "" then
    return
  end

  local cmd = {
    "rg",
    "--vimgrep",
    "--smart-case",
    "--hidden",
    "--glob",
    "!.git",
    "--",
    pattern,
  }

  local result = vim.system(cmd, { text = true, cwd = vim.uv.cwd() }):wait()

  if result.code > 1 then
    vim.notify(result.stderr or "grep failed", vim.log.levels.ERROR)
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

vim.keymap.set("n", "<leader>fg", function()
  vim.ui.input({ prompt = "Grep: " }, grep_to_qflist)
end, { silent = true, desc = "Grep prompt" })
