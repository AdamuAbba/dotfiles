local wk = require("which-key")
local snacks = require("snacks")
local mini_extra = require("mini.extra")
local custom_border = require("lib.icons").custom_border

vim.lsp.diagnostics = {
  virtual_lines = false,
  virtual_text = false,
  update_in_insert = false,
  float = {
    border = custom_border,
    source = true,
  },
}

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
            snacks.picker.lsp_config()
          end,
          mode = { "n" },
          desc = "Lsp Info",
        },
      })
    end

    ---- inlayHints keymaps
    if client ~= nil and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    ------ rename keymaps
    if client ~= nil and client:supports_method("textDocument/rename") then
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
    if client ~= nil and client:supports_method("textDocument/typeDefinition") then
      wk.add({
        {
          "gy",
          function()
            mini_extra.pickers.lsp({ scope = "type_definition" })
          end,
          desc = "[LSP] Type Definition",
        },
      })
    end

    ------ reference keymaps
    if client ~= nil and client:supports_method("textDocument/references") then
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

    ------ declaration keymaps
    if client ~= nil and client:supports_method("textDocument/declaration") then
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

    ------ definition keymaps
    if client ~= nil and client:supports_method("textDocument/definition") then
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
          LazyVim.lsp.action.source,
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
          "<C-k>",
          function()
            if vim.fn.pumvisible() == 1 then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-e>", true, false, true), "n", false)
              vim.schedule(vim.lsp.buf.signature_help)
            else
              vim.lsp.buf.signature_help()
            end
          end,
          mode = { "n", "i" },
          desc = "[LSP] Signature Help",
        },
      })
    end

    ------ symbols keymaps
    if client ~= nil and client:supports_method("textDocument/documentSymbol") then
      wk.add({
        {
          "<leader>ss",
          function()
            mini_extra.pickers.lsp({ scope = "document_symbol" })
          end,
          mode = { "n" },
          desc = "[LSP] buffer Symbols",
        },
        {
          "<leader>sS",
          function()
            mini_extra.pickers.lsp({ scope = "workspace_symbol" })
          end,
          desc = "[LSP] Workspace Symbols",
        },
      })
    end

    ------ inline completion keymaps
    if client ~= nil and client:supports_method("textDocument/inlineCompletion") then
      vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
      wk.add({
        {
          "<Tab>",
          function()
            if not vim.lsp.inline_completion.get() then
              return "<Tab>"
            end
          end,
          expr = true,
          replace_keycodes = true,
          desc = "[LSP] Accept inline Suggestion",
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

    ------ completion keymaps
    if client ~= nil and client:supports_method("textDocument/completion") then
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
          -- Remove leading misc chars for abbr name,
          -- and cap field to 25 chars
          --local abbr = item.label
          --abbr = abbr:match("[%w_.]+.*") or abbr
          --abbr = #abbr > 25 and abbr:sub(1, 24) .. "…" or abbr
          --
          -- Remove return value
          --local menu = ""

          -- Only show abbr name, remove leading misc chars (bullets etc.),
          -- and cap field to 15 chars
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

    ----- Hover keymaps
    if client ~= nil and client:supports_method("textDocument/hover") then
      wk.add({
        {
          "K",
          function()
            local filetype = vim.bo.filetype
            if filetype == "vim" or filetype == "help" then
              vim.cmd("h " .. vim.fn.expand("<cword>"))
            elseif filetype == "man" then
              vim.cmd("Man " .. vim.fn.expand("<cword>"))
            elseif filetype == "rust" then
              vim.cmd.RustLsp({ "hover", "actions" })
            elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
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
  end,
})
