-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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

--============================================= reload keymaps =============================================
-- local function reload_keymaps()
--   -- clear cached module
--   package.loaded["config.keymaps"] = nil
--
--   -- reload by module name
--   require("config.keymaps")
--
--   vim.notify("Keymaps reloaded!", vim.log.levels.INFO, {
--     title = "Neovim",
--     timeout = 3000,
--   })
-- end
--
-- vim.api.nvim_create_user_command("ReloadKeymaps", reload_keymaps, {})
--
-- local keymaps_file = vim.fn.stdpath("config") .. "/lua/config/keymaps.lua"
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = keymaps_file,
--   callback = reload_keymaps,
-- })
