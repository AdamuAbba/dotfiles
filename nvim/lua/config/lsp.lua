local wk = require("which-key")

--============================================= diagnostics =============================================
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_lines = false,
  virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
  float = {
    border = "rounded",
    source = true,
  },
})

--============================================= servers =============================================
-- Per-server settings live in after/lsp/<server>.lua. This list is what actually starts.
vim.lsp.config("*", {
  capabilities = {
    workspace = { fileOperations = { didRename = true, willRename = true } },
  },
})

vim.lsp.enable({
  "bacon_ls",
  "bashls",
  "clangd",
  "copilot",
  "cssls",
  "docker_compose_language_service",
  "dockerls",
  "eslint",
  "ghostty",
  "graphql",
  "harper_ls",
  "html",
  "jsonls",
  "just",
  "kotlin_language_server",
  "lemminx",
  "lua_ls",
  "marksman",
  "neocmake",
  "nil_ls",
  "pyright",
  "rubocop",
  "ruby_lsp",
  "ruff",
  "rust_analyzer",
  "statix",
  "tailwindcss",
  "tombi",
  "tsc",
  "yamlls",
})

--============================================= lsp on attach =============================================
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    ------ global lsp keymaps
    if client ~= nil then
      wk.add({
        {
          "<leader>cl",
          function()
            vim.cmd("checkhealth vim.lsp")
          end,
          mode = { "n" },
          desc = "Lsp Info",
        },

        ------ diagnostics
        {
          "<leader>sd",
          function()
            vim.diagnostic.setloclist({ open = true, title = "Buffer Diagnostics" })
          end,
          desc = "Buffer Diagnostics",
        },
        {
          "<leader>sD",
          function()
            vim.diagnostic.setqflist({ open = true, title = "Workspace Diagnostics" })
          end,
          desc = "Workspace Diagnostics",
        },
      })

      ---- inlayHints keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      ------ folds from the server when it supports them (replaces LazyVim's lsp folds)
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then
        for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
          vim.wo[win][0].foldmethod = "expr"
          vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
      end

      ------ rename keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_rename) then
        wk.add({
          {
            "<leader>cr",
            function()
              vim.lsp.buf.rename()
            end,
            desc = "Rename",
          },
        })
      end

      ------ typeDefinition keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_typeDefinition) then
        wk.add({
          {
            "gy",
            function()
              vim.lsp.buf.type_definition()
            end,
            desc = "[LSP] Type Definition",
          },
        })
      end

      ------ reference keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_references) then
        wk.add({
          {
            "gr",
            function()
              vim.lsp.buf.references()
            end,
            nowait = true,
            desc = "[LSP] References",
            mode = { "n" },
          },
        })
      end

      ------ symbols keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentSymbol) then
        wk.add({
          {
            "<leader>ss",
            function()
              vim.lsp.buf.document_symbol()
            end,
            mode = { "n" },
            desc = "[LSP] buffer Symbols",
          },
          {
            "<leader>sS",
            function()
              vim.lsp.buf.workspace_symbol()
            end,
            desc = "[LSP] Workspace Symbols",
          },
        })
      end

      ----- Hover keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_hover) then
        wk.add({
          {
            "K",
            function()
              local filetype = vim.bo.filetype
              if filetype == "vim" or filetype == "help" then
                vim.cmd("h " .. vim.fn.expand("<cword>"))
              elseif filetype == "man" then
                vim.cmd("Man " .. vim.fn.expand("<cword>"))
              -- elseif filetype == "rust" then
              --   vim.cmd.RustLsp({ "hover", "actions" })
              elseif
                vim.fn.expand("%:t") == "Cargo.toml"
                and pcall(require, "crates")
                and require("crates").popup_available()
              then
                require("crates").show_popup()
              else
                vim.lsp.buf.hover()
              end
            end,
            mode = { "n" },
            desc = "[LSP] Hover",
          },
        })
      end

      ------ declaration keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_declaration) then
        wk.add({
          {
            "gD",
            function()
              vim.lsp.buf.declaration()
            end,
            desc = "[LSP] Declaration",
            mode = { "n" },
          },
        })
      end

      ------ completion keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
        wk.add({
          {
            "<C-Space>",
            function()
              vim.lsp.completion.get()
            end,
            desc = "Trigger lsp completion",
            mode = { "i" },
          },
        })
        vim.lsp.completion.enable(true, client.id, ev.buf, {
          autotrigger = true,
          convert = function(item)
            local abbr = item.label
            abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
            abbr = abbr:match("[%w_.]+.*") or abbr
            abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr

            -- Cap return value field to 15 chars
            local menu = item.detail or ""
            menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu

            return { abbr = abbr, menu = menu }
          end,
        })
      end

      ------ inline completion keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
        vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
        wk.add({
          {
            "<Tab>",
            function()
              if not vim.lsp.inline_completion.get() then
                ---@diagnostic disable-next-line: redundant-return-value
                return "<Tab>"
              end
              ---@diagnostic disable-next-line: redundant-return-value
              return "  "
            end,
            expr = true,
            replace_keycodes = true,
            mode = { "i" },
          },
          {
            "<M-n>",
            function()
              vim.lsp.inline_completion.select({ count = 1 })
            end,
            desc = "[LSP] Next inline Suggestion",
            mode = { "i" },
          },
          {
            "<M-p>",
            function()
              vim.lsp.inline_completion.select({ count = -1 })
            end,
            desc = "[LSP] Prev inline Suggestion",
            mode = { "i" },
          },
        })
      end

      ------ definition keymaps
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_definition) then
        wk.add({
          {
            "gd",
            function()
              vim.lsp.buf.definition()
            end,
            desc = "[LSP] Definition",
            mode = { "n" },
          },
        })
      end
    end

    ------ cadeAction keymaps
    if client ~= nil and client:supports_method("textDocument/codeAction") then
      wk.add({
        {
          "<leader>ca",
          function()
            vim.lsp.buf.code_action()
          end,
          desc = "Code Action",
          mode = { "n", "x" },
        },
        {
          "<leader>cA",
          function()
            vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
          end,
          desc = "Source Action",
          mode = { "n", "x" },
        },
      })
    end

    ------ implementation keymaps
    if client ~= nil and client:supports_method("textDocument/implementation") then
      wk.add({
        {
          "gI",
          function()
            vim.lsp.buf.implementation()
          end,
          desc = "[LSP] Implementation",
        },
      })
    end

    ------ signatureHelp keymaps
    if client ~= nil and client:supports_method("textDocument/signatureHelp") then
      wk.add({
        {
          "gk",
          function()
            if vim.fn.pumvisible() == 1 then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-e>", true, false, true), "n", false)
              vim.schedule(vim.lsp.buf.signature_help)
            else
              vim.lsp.buf.signature_help()
            end
          end,
          mode = { "n" },
          desc = "[LSP] Signature Help",
        },
      })
    end
  end,
})
