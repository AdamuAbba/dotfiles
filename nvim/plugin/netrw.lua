vim.g.netrw_preview = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
vim.g.netrw_browse_split = 0
vim.g.netrw_altfile = 1 -- keep the alternate file correct
local map = vim.keymap.set

-- Open the netrw side panel at the current file's directory and put the cursor
-- on that file, instead of dropping into the cwd root.
local function toggle_netrw()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "netrw" then
      vim.cmd("Lexplore")
      return
    end
  end

  local file = vim.api.nvim_buf_get_name(0)
  if file == "" or vim.bo.buftype ~= "" or vim.fn.filereadable(file) == 0 then
    vim.cmd("Lexplore")
    return
  end

  vim.cmd("Lexplore " .. vim.fn.fnameescape(vim.fn.fnamemodify(file, ":h")))

  local name = vim.fn.escape(vim.fn.fnamemodify(file, ":t"), "\\")
  vim.fn.cursor(1, 1)
  vim.fn.search([[\V\^\%(| \)\*]] .. name .. [[\$]], "cW")
end

vim.keymap.set("n", "<leader>fm", toggle_netrw, { silent = true, desc = "Netrw (current file)" })

------ netrw buffer-local keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function(args)
    pcall(vim.keymap.del, "n", "<C-l>", { buffer = args.buf })
    map("n", "<C-l>", "<C-w>l", { buffer = args.buf, silent = true, desc = "Window right" })
    map("n", "q", ":Lexplore<cr>", { buffer = args.buf, silent = true, desc = "Close Explorer" })
    map("n", "<ESC>", ":Lexplore<cr>", { buffer = args.buf, silent = true, desc = "Close Explorer" })
  end,
})

-- netrw's built-in `%` opens new files in the netrw window instead of
-- respecting `netrw_browse_split`. Override it to open in the previous window.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "%", function()
      local fname = vim.fn.input("Enter filename: ")
      if fname == "" then
        return
      end

      local dir = vim.b.netrw_curdir or vim.fn.getcwd()
      local path = dir .. "/" .. fname

      if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
        vim.notify("Already exists: " .. fname, vim.log.levels.WARN)
        return
      end

      if fname:match("/$") then
        vim.fn.mkdir(path, "p")
        vim.cmd("edit")
      else
        local f = io.open(path, "w")
        if not f then
          vim.notify("Failed to create: " .. fname, vim.log.levels.ERROR)
          return
        end
        f:close()

        local escaped = vim.fn.fnameescape(path)
        if vim.fn.winnr("#") == 0 then
          vim.cmd("edit " .. escaped)
        else
          vim.cmd("wincmd p")
          vim.cmd("edit " .. escaped)
        end
      end
    end, { buffer = true, silent = true, noremap = true, desc = "Create file in previous window" })
  end,
})
