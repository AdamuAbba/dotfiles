return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        marksman = {
          enabled = false,
        },
        ["*"] = {
          keys = {
            {
              "gd",
              function()
                vim.lsp.buf.definition({
                  on_list = function(data)
                    if #data.items == 0 then
                      vim.notify("No definitions found", vim.log.levels.WARN)
                    elseif #data.items == 1 then
                      -- Jump directly
                      local item = data.items[1]
                      vim.cmd(string.format("edit %s", vim.fn.fnameescape(item.filename)))
                      vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
                    else
                      require("mini.extra").pickers.lsp({ scope = "definition" })
                    end
                  end,
                })
              end,
              desc = "[LSP] Definition",
            },
            {
              "gD",
              function()
                vim.lsp.buf.declaration({
                  on_list = function(data)
                    if #data.items == 0 then
                      vim.notify("No declarations found", vim.log.levels.WARN)
                    elseif #data.items == 1 then
                      -- Jump directly
                      local item = data.items[1]
                      vim.cmd(string.format("edit %s", vim.fn.fnameescape(item.filename)))
                      vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
                    else
                      require("mini.extra").pickers.lsp({ scope = "declaration" })
                    end
                  end,
                })
              end,
              desc = "[LSP] Declaration",
            },
            {
              "gr",
              function()
                require("mini.extra").pickers.lsp({ scope = "references" })
              end,
              nowait = true,
              desc = "[LSP] +References",
            },
            {
              "gI",
              function()
                require("mini.extra").pickers.lsp({ scope = "implementation" })
              end,
              desc = "[LSP] Implementation",
            },
            {
              "gy",
              function()
                require("mini.extra").pickers.lsp({ scope = "type_definition" })
              end,
              desc = "[LSP] Type Definition",
            },
            {
              "<leader>ss",
              function()
                require("mini.extra").pickers.lsp({ scope = "document_symbol" })
              end,
              desc = "[LSP] buffer Symbols",
            },
            {
              "<leader>sS",
              function()
                require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
              end,
              desc = "[LSP] Workspace Symbols",
            },
            {
              "gai",
              false,
            },
            {
              "gao",
              false,
            },
          },
        },
      },
    },
  },
}
