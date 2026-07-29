--============================================= LspProgress =============================================
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value
    local msg = value.message or "done"

    if #msg > 40 then
      msg = msg:sub(1, 37) .. "..."
    end

    vim.api.nvim_echo({ { msg } }, false, {
      id = "lsp." .. ev.data.client_id,
      kind = "progress",
      source = "vim.lsp",
      title = value.title,
      status = value.kind ~= "end" and "running" or "success",
      percent = value.percentage,
    })
  end,
})

--============================================= Completion =============================================
vim.api.nvim_create_autocmd("InsertCharPre", {
  callback = function()
    if vim.fn.pumvisible() == 1 or vim.fn.state("m") == "m" then
      return
    end

    local clients = vim.lsp.get_clients({ bufnr = 0 })

    if next(clients) ~= nil then
      vim.lsp.completion.get()
    else
      local key = vim.keycode("<C-x><C-n>")
      vim.api.nvim_feedkeys(key, "m", false)
    end
  end,
})

vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = { ":", "/", "?" },
  callback = function()
    vim.fn.wildtrigger()
  end,
})
--============================================= Force set buffer options =============================================
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt_local.spell = false
  end,
})
--============================================= Disable diagnostic for help buffers/update some highlights ===========
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  pattern = "markdown",
  callback = function(args)
    local file_path = vim.api.nvim_buf_get_name(args.buf)
    if file_path:find("^/Users/abba/%.local/state/nvim/") then
      vim.diagnostic.enable(false, { bufnr = args.buf })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "markdown", "lazy" },
  callback = function(args)
    vim.o.cursorcolumn = false
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})
--============================================= no continue comments on new line ====================================
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
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
    local mini_snips = require("mini.snippets")

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
            vim.schedule(function()
              mini_snips.default_insert({ body = content })
            end)
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
        vim.schedule(function()
          mini_snips.default_insert({ body = content })
        end)

        return
      end
    end
  end,
})
