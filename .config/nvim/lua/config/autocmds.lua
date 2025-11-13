-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local wk = require("which-key")

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_set_hl(0, "CursorColumn", { bg = "NONE" })
  end,
})

--============================================= Template files for nvim =============================================
-- copied and modified from author/source [https://zignar.net/2024/11/20/template-files-for-nvim/]

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = vim.api.nvim_create_augroup("templates", { clear = true }),
  desc = "Load template file",
  callback = function(args)
    if args.event == "BufReadPost" and vim.fn.line2byte(vim.fn.line("$")) > 1 then
      return -- skip if file is not empty on read
    end

    local fpath = args.file
    local home = os.getenv("HOME")
    local fname = vim.fn.fnamemodify(args.file, ":t")
    local ext = vim.fn.fnamemodify(args.file, ":e")
    local candidates = { fname, ext }
    local uv = vim.uv
    local luasnip = require("luasnip")

    -- Map file name patterns to specific template files
    local template_map = {
      ["%.tsx$"] = "component.tsx.stpl",
      ["%.kbe.json$"] = "kbe.json.stpl",
      ["%.jsx$"] = "component.jsx.stpl",
      ["%.sh$"] = "sh.stpl",
      ["index%.ts$"] = "index.ts.stpl",
      ["plugins/.*%.lua$"] = "plugin.lua.stpl",
    }
    --
    -- -- Pattern-matching logic
    for pattern, tmpl_name in pairs(template_map) do
      if fpath:match(pattern) or fname:match(pattern) then
        local tmpl_path = home .. "/.config/nvim/templates/" .. tmpl_name
        ---@diagnostic disable-next-line: undefined-field
        if uv.fs_stat(tmpl_path) then
          local f = io.open(tmpl_path, "r")
          if f then
            local content = f:read("*a")
            f:close()
            luasnip.lsp_expand(content)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>i", true, false, true), "n", false)
            return
          end
        end
      end
    end

    -- Fallback to name or extension match
    for _, candidate in ipairs(candidates) do
      local tmpl = table.concat({ home, "/.config/nvim/templates/", candidate, ".tpl" })
      ---@diagnostic disable-next-line: undefined-field
      if uv.fs_stat(tmpl) then
        vim.cmd("0r " .. tmpl)
        return
      end
    end

    for _, candidate in ipairs(candidates) do
      local tmpl = table.concat({ home, "/.config/nvim/templates/", candidate, ".stpl" })
      local f = io.open(tmpl, "r")
      if f then
        local content = f:read("*a")
        f:close()
        luasnip.lsp_expand(content)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>i", true, false, true), "n", false)
        return
      end
    end
  end,
})

--============================================= git hooks as sh files =============================================
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    ".git/hooks/*",
    vim.fn.expand("~/.config/vectorcode/hooks/*"),
  },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

--============================================= auto cwd =============================================
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     local args = vim.fn.argv()
--     if #args > 0 then
--       local arg = args[1]
--       local stat = vim.loop.fs_stat(arg)
--       if stat and stat.type == "directory" then
--         vim.cmd("cd " .. arg)
--       else
--         vim.cmd("cd " .. vim.fn.fnamemodify(arg, ":p:h"))
--       end
--     end
--   end,
-- })

--============================================= open README or Todo on dir open ======================
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.fn.argc() ~= 1 then
--       return
--     end
--     local dir = vim.fn.argv(0)
--     if vim.fn.isdirectory(dir) ~= 1 then
--       return
--     end
--
--     local function exists(path)
--       return vim.loop.fs_stat(path) ~= nil
--     end
--
--     local try_files = {
--       -- README priority (common variants)
--       "README.md",
--       "README.markdown",
--       "README.MD",
--       "README",
--       -- Todo priority (common variants)
--       "Todo.md",
--       "TODO.md",
--       "todo.md",
--     }
--
--     for _, name in ipairs(try_files) do
--       local path = dir .. "/" .. name
--       if exists(path) then
--         -- open the file as the active buffer
--         vim.cmd("edit " .. vim.fn.fnameescape(path))
--
--         -- try to tell snacks.explorer to reveal/highlight the file (no-op if API differs)
--         -- local ok, explorer = pcall(require, "snacks.explorer")
--         -- if ok and explorer then
--         --   if type(explorer.reveal) == "function" then
--         --     pcall(explorer.reveal, path)
--         --   elseif type(explorer.open) == "function" then
--         --     pcall(explorer.open) -- fallback: open explorer
--         --   end
--         -- end
--
--         return
--       end
--     end
--     -- otherwise leave default behavior
--   end,
-- })
