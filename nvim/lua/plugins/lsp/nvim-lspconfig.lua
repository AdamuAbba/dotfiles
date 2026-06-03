return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local custom_border = require("lib.icons").custom_border

      --============================================= COPILOT LSP =============================================
      local copilot_lsp_config_original = vim.lsp.config["copilot"] or {}
      local copilot_lsp_config_original_on_attach = copilot_lsp_config_original.on_attach
      --=======================================================================================================

      ---@type vim.diagnostic.Opts
      opts.diagnostics = {
        virtual_lines = false,
        virtual_text = true,
        update_in_insert = false,
        float = {
          border = custom_border,
          source = true,
        },
      }
      opts.autoformat = false
      opts.codelens = {
        enabled = false,
      }
      -- LSP Server Settings
      -- Sets the default configuration for an LSP client (or all clients if the special name "*" is used).
      ---@diagnostic disable-next-line: duplicate-doc-alias
      ---@alias lazyvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean, keys?:LazyKeysLspSpec[]}
      ---@type table<string, lazyvim.lsp.Config|boolean>
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        --============================================= disabled =============================================
        rust_analyzer = {
          enabled = false,
        },
        marksman = {
          enabled = false,
        },
        --============================================= enabled =============================================
        kulala_lsp = {
          enabled = true,
        },
        just = {
          enabled = true,
        },
        eslint = {
          enabled = true,
          workspace_required = true,
          ---@type lspconfig.settings.eslint
          settings = {
            lintTask = {
              enable = true,
            },
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = "separateLine",
              },
              showDocumentation = {
                enable = true,
              },
            },
            codeActionOnSave = {
              enable = false,
              mode = "all",
            },
            experimental = {
              useFlatConfig = true,
            },
            format = false,
            nodePath = "",
            onIgnoredFiles = "off",
            problems = {
              shortenToSingleLine = false,
            },
            quiet = false,
            rulesCustomizations = {},
            run = "onType",
            useESLintClass = false,
            validate = "on",
            workingDirectory = {
              mode = "auto",
            },
          },
        },
        bashls = {
          enabled = true,
          filetypes = { "bash", "zsh", "sh" },
        },
        lua_ls = {
          enabled = true,
          mason = true,
          ---@type lspconfig.settings.lua_ls
          settings = {
            Lua = {
              hint = {
                enable = true,
                semicolon = "Disable",
                arrayIndex = "Disable",
                await = true,
                awaitPropagte = true,
                paramType = true,
                paramName = "All",
                setType = true,
              },
              codeLens = {
                enable = false,
              },
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
        harper_ls = {
          enabled = true,
          filetypes = { "markdown" },
          settings = {
            ["harper-ls"] = {
              userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
              linters = {
                SentenceCapitalization = false,
                SpellCheck = true,
                SpelledNumbers = false,
                AnA = true,
                UnclosedQuotes = false,
                QuotesSpacing = false,
                WrongQuotes = false,
                LongSentences = true,
                RepeatedWords = true,
                Spaces = true,
                Matcher = true,
                CorrectNumberSuffix = true,
                ToDoHyphen = false,
                AvoidCurses = false,
              },
              codeActions = {
                ForceStable = false,
              },
              markdown = {
                IgnoreLinkTitle = true,
              },
              diagnosticSeverity = "hint",
              isolateEnglish = true,
              excludePatterns = {
                "/Users/abba/.local/state/nvim/**",
              },
            },
          },
        },
        biome = {
          enabled = false,
        },
        oxlint = {
          enabled = false,
          settings = {
            fixKind = "all",
          },
        },
        --- disable the oxfmt LSP server since we use conform for formatting
        oxfmt = {
          enabled = false,
        },
        copilot = {
          enabled = true,
          keys = {},
          on_attach = function(client, bufnr)
            if copilot_lsp_config_original_on_attach then
              copilot_lsp_config_original_on_attach(client, bufnr)
            end

            -- Disable Copilot completion for some files "Need to get off the AI high somehow"
            -- list would increase with time till I'm clean and my brain works like it used to again.
            local exclude_filetypes = { "rust", "lua" }
            local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr, scope = "local" })
            for _, excluded in ipairs(exclude_filetypes) do
              if ft == excluded then
                client:stop()
                return
              end
            end
          end,
        },
        bacon_ls = {
          enabled = vim.g.lazyvim_rust_diagnostics == "bacon-ls",
          init_options = {
            updateOnSave = true,
            updateOnSaveWaitMillis = 1000,
            runBaconInBackground = true,
          },
        },
        cssls = {
          enabled = true,
        },
        markdown_oxide = {
          enabled = true,
        },
        tmux = {
          enabled = true,
          cmd = { "tmux-language-server" },
          filetypes = { "tmux" },
        },
        tsgo = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          --- @type lspconfig.settings.vtsls
          --- using vtsls types since it's same with tsgo (I think?)
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = {
                  enabled = "literals",
                  suppressWhenArgumentMatchesName = true,
                },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        },
        ["*"] = {
          keys = {
            {
              "<Tab>",
              function()
                if not vim.lsp.inline_completion.get() then
                  return "<Tab>"
                end
              end,
              {
                expr = true,
                replace_keycodes = true,
                desc = "[LSP] Accept inline Suggestion",
              },
              has = "textDocument/inlineCompletion",
              mode = { "i" },
            },
            {
              "<M-n>",
              function()
                vim.lsp.inline_completion.select({ count = 1 })
              end,
              desc = "[LSP] Next inline Suggestion",
              has = "textDocument/inlineCompletion",
              mode = { "i" },
            },
            {
              "<M-p>",
              function()
                vim.lsp.inline_completion.select({ count = -1 })
              end,
              desc = "[LSP] Prev inline Suggestion",
              mode = { "i" },
              has = "textDocument/inlineCompletion",
            },
            {
              "<leader>cl",
              function()
                Snacks.picker.lsp_config()
              end,
              desc = "Lsp Info",
            },
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
              desc = "[LSP] Hover",
              has = "textDocument/hover",
            },
            {
              "<leader>ss",
              function()
                require("mini.extra").pickers.lsp({ scope = "document_symbol" })
              end,
              desc = "[LSP] buffer Symbols",
              has = "textDocument/documentSymbol",
            },
            {
              "<leader>sS",
              function()
                require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
              end,
              desc = "[LSP] Workspace Symbols",
            },
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
              has = "textDocument/definition",
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
              has = "textDocument/declaration",
            },
            {
              "gr",
              function()
                require("mini.extra").pickers.lsp({ scope = "references" })
              end,
              nowait = true,
              desc = "[LSP] References",
              has = "textDocument/references",
            },
            {
              "gI",
              function()
                require("mini.extra").pickers.lsp({ scope = "implementation" })
              end,
              desc = "[LSP] Implementation",
              has = "textDocument/implementation",
            },
            {
              "gy",
              function()
                require("mini.extra").pickers.lsp({ scope = "type_definition" })
              end,
              desc = "[LSP] Type Definition",
              has = "textDocument/typeDefinition",
            },
            {
              "gK",
              function()
                return vim.lsp.buf.signature_help()
              end,
              mode = "n",
              desc = "[LSP] Signature Help",
              has = "textDocument/signatureHelp",
            },
            ---handled by blink
            {
              "<C-k>",
              false,
            },
            {
              "<leader>ca",
              vim.lsp.buf.code_action,
              desc = "Code Action",
              mode = { "n", "x" },
              has = "textDocument/codeAction",
            },
            {
              "<leader>cc",
              vim.lsp.codelens.run,
              desc = "Run Codelens",
              mode = { "n", "x" },
              has = "textDocument/codeLens",
            },
            {
              "<leader>cC",
              false,
            },
            {
              "<leader>cR",
              function()
                Snacks.rename.rename_file()
              end,
              desc = "Rename File",
              mode = { "n" },
              has = {
                "workspace/didRenameFiles",
                "workspace/willRenameFiles",
              },
            },
            {
              "<leader>cr",
              vim.lsp.buf.rename,
              desc = "Rename",
              has = { "textDocument/rename" },
            },
            {
              "<leader>cA",
              LazyVim.lsp.action.source,
              desc = "Source Action",
              has = { "textDocument/codeAction" },
            },
            {
              "]]",
              false,
            },
            {
              "[[",
              false,
            },
            {
              "<a-n>",
              false,
            },
            {
              "<a-p>",
              false,
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
      })
      return opts
    end,
  },
}
