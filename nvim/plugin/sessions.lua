-- Minimal session management, modeled on natecraddock/sessions.nvim.
-- Sessions are stored in one directory, named after the cwd they belong to.
--
-- Automatic, no commands needed, but only for runs that name a directory:
-- `nvim .` or `nvim ~/proj` restores that directory's session, writes it on
-- exit, and swaps sessions when the global cwd changes. Plain `nvim` with no
-- arguments stays a scratch run: nothing is restored and nothing is written,
-- unless a cd or :SessionsSave adopts a session. :SessionsStop opts back out.

vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

local session_dir = vim.fn.stdpath("data") .. "/sessions"
local group = vim.api.nvim_create_augroup("sessions", { clear = true })
local autosave = false -- on once this run owns a session
local from_stdin = false
local ready = false -- nothing is worth saving until startup finished
local loading = false -- sourcing a session cds, which would re-enter DirChanged

-- ~/dev/dotfiles -> <data>/sessions/%Users%abba%dev%dotfiles.vim
local function path_for(cwd)
  return session_dir .. "/" .. (cwd:gsub("[\\/:]+", "%%")) .. ".vim"
end

local function resolve(arg)
  if arg and arg ~= "" then
    return vim.fn.fnamemodify(arg, ":p")
  end
  return path_for(vim.uv.cwd())
end

-- An empty layout is never worth persisting: it would overwrite a good session
-- with nothing, e.g. when a cd happens before startup finishes.
local function has_files()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= "" then
      return true
    end
  end
  return false
end

-- mksession records a netrw window as `edit NetrwTreeListing`, a buffer name
-- with no file behind it, so sourcing the session creates an empty buffer of
-- that name and the sidebar comes back blank. Take netrw out of the layout
-- before writing instead.
local function drop_netrw()
  local found = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) and vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "netrw" then
      found = true
      -- Closing the last window would exit nvim, so show a real file there.
      if #vim.api.nvim_list_wins() > 1 then
        pcall(vim.api.nvim_win_close, win, true)
      else
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= "" and vim.bo[buf].filetype ~= "netrw" then
            vim.api.nvim_win_set_buf(win, buf)
            break
          end
        end
      end
    end
  end
  return found
end

-- `restore` is for :SessionsSave, where the user keeps working afterwards and
-- expects the sidebar to still be there. On exit and on a cd the layout is
-- about to be discarded anyway, so reopening it would just be churn.
local function save(path, restore)
  path = resolve(path)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  local had_netrw = drop_netrw()
  vim.cmd("mksession! " .. vim.fn.fnameescape(path))
  if had_netrw and restore then
    vim.cmd("Lexplore")
  end
  return path
end

local function load(path)
  path = resolve(path)
  if vim.fn.filereadable(path) == 0 then
    return nil
  end
  loading = true
  vim.cmd("silent! source " .. vim.fn.fnameescape(path))
  loading = false
  return path
end

vim.api.nvim_create_autocmd("StdinReadPre", {
  group = group,
  callback = function()
    from_stdin = true
  end,
})

-- Which directory this run is a workspace for: only `nvim .` or `nvim ~/dir`.
-- Bare `nvim` and opening files directly are one-offs, left alone entirely.
local function startup_dir()
  if from_stdin then
    return nil
  end
  if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    return vim.fn.fnamemodify(vim.fn.argv(0), ":p"):gsub("/$", "")
  end
  return nil
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  nested = true, -- let restored buffers fire FileType, LSP attach, etc.
  callback = function()
    local dir = startup_dir()
    if dir then
      autosave = true -- a first visit still gets a session written on exit
      if vim.fn.filereadable(path_for(dir)) == 1 then
        loading = true
        vim.cmd("silent! cd " .. vim.fn.fnameescape(dir)) -- may be `nvim ~/other`
        vim.cmd("silent! %bwipeout!") -- drop the netrw buffer `nvim .` opened
        loading = false
        load()
      end
    end
    ready = true
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function()
    if autosave and ready and has_files() then
      save()
    end
  end,
})

-- Write the outgoing directory's session while its cwd is still current, so
-- mksession records the right `cd`.
vim.api.nvim_create_autocmd("DirChangedPre", {
  group = group,
  pattern = "global",
  callback = function()
    if autosave and ready and not loading and has_files() then
      save()
    end
  end,
})

-- Then trade the whole buffer list for the incoming directory's session.
vim.api.nvim_create_autocmd("DirChanged", {
  group = group,
  pattern = "global",
  nested = true,
  callback = function()
    if loading or not ready then
      return
    end

    -- The old layout now sits in the new directory. Persisting it here would
    -- overwrite the incoming directory's session, so bail out of autosaving
    -- entirely rather than guess.
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].modified then
        autosave = false
        vim.notify("Unsaved changes: session not swapped, autosave off", vim.log.levels.WARN)
        return
      end
    end

    loading = true
    vim.cmd("silent! %bwipeout!") -- also kills terminal jobs in this instance
    loading = false
    if load() then -- no session for this directory yet: stay on the clean slate
      autosave = true
    end
  end,
})

vim.api.nvim_create_user_command("SessionsSave", function(opts)
  autosave = true
  vim.notify("Session saved: " .. save(opts.args, true), vim.log.levels.INFO)
end, { nargs = "?", complete = "file", desc = "Save session now and keep autosaving" })

vim.api.nvim_create_user_command("SessionsLoad", function(opts)
  if load(opts.args) then
    autosave = true
  else
    vim.notify("No session at " .. resolve(opts.args), vim.log.levels.WARN)
  end
end, { nargs = "?", complete = "file", desc = "Load a session and keep autosaving" })

vim.api.nvim_create_user_command("SessionsStop", function()
  autosave = false
  vim.notify("Session autosave off for this run", vim.log.levels.INFO)
end, { desc = "Stop autosaving for this run (session file left as-is)" })
