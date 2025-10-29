return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-git",
      "moyiz/blink-emoji.nvim",
      "archie-judd/blink-cmp-words",
      "bydlw98/blink-cmp-env",
      "ph1losof/ecolog.nvim",
      "alexandre-abrioux/blink-cmp-npm.nvim",
      "disrupted/blink-cmp-conventional-commits",
      "marcoSven/blink-cmp-yanky",
      {
        "bydlw98/blink-cmp-sshconfig",
        build = "make",
      },
    },
    ---@module 'blink.cmp'
    ---@param _ any
    ---@param opts blink.cmp.Config
    opts = function(_, opts)
      opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
        ["<Up>"] = false,
        ["<Down>"] = false,
        ["<C-e>"] = false,
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = false,
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      })
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        ---@diagnostic disable-next-line: param-type-mismatch
        default = vim.list_extend(opts.sources.default or {}, {
          "npm",
          "conventional_commits",
          "ecolog",
          "git",
          "emoji",
          "dictionary",
          "env",
          "sshconfig",
          -- "yank",
        }),
        providers = vim.tbl_deep_extend("force", opts.sources.providers or {}, {
          -- yank = {
          --   name = "yank",
          --   module = "blink-yanky",
          --   opts = {
          --     minLength = 5,
          --     onlyCurrentFiletype = true,
          --     trigger_characters = { ";;;" },
          --     kind_icon = "󰅍",
          --   },
          -- },
          sshconfig = {
            name = "SshConfig",
            module = "blink-cmp-sshconfig",
          },
          ecolog = {
            name = "ecolog",
            module = "ecolog.integrations.cmp.blink_cmp",
            enabled = true,
          },
          conventional_commits = {
            name = "Conventional Commits",
            module = "blink-cmp-conventional-commits",
            enabled = function()
              return vim.bo.filetype == "gitcommit"
            end,
            opts = {},
          },
          env = {
            name = "Env",
            module = "blink-cmp-env",
            opts = {
              item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
              show_braces = false,
              show_documentation_window = true,
            },
          },
          dictionary = {
            name = "blink-cmp-words",
            module = "blink-cmp-words.dictionary",
            enabled = function()
              return vim.tbl_contains({ "markdown" }, vim.bo.filetype)
            end,
            opts = {
              -- The number of characters required to trigger completion.
              -- Set this higher if completion is slow, 3 is default.
              dictionary_search_threshold = 3,
              score_offset = 0,
              definition_pointers = { "!", "&", "^" },
            },
          },
          npm = {
            name = "npm",
            module = "blink-cmp-npm",
            async = true,
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = {
              insert = true,
              trigger = function()
                return { "e:" }
              end,
            },
            should_show_items = function()
              return vim.tbl_contains({ "lua", "gitcommit", "markdown" }, vim.o.filetype)
            end,
          },
          git = {
            module = "blink-cmp-git",
            name = "Git",
            enabled = function()
              return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
            end,
            --- @module 'blink-cmp-git'
            --- @type blink-cmp-git.Options
            opts = {},
          },
        }),
      })
      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        trigger = {
          prefetch_on_insert = true,
          show_in_snippet = true,
          show_on_backspace = false,
          show_on_backspace_in_keyword = false,
          show_on_backspace_after_accept = true,
          show_on_backspace_after_insert_enter = true,
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_insert = true,
          show_on_accept_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        ghost_text = {
          enabled = false,
        },
        menu = {
          auto_show = true,
          border = "rounded",
          cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then
              local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
              return { pos[1] + 0.4, pos[2] }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = "rounded",
          },
        },
      })
      opts.signature = vim.tbl_deep_extend("force", opts.signature or {}, {
        enabled = true,
        window = {
          border = "rounded",
          show_documentation = false,
        },
      })
      --CMDLINE specific config
      opts.cmdline = vim.tbl_deep_extend("force", opts.cmdline or {}, {
        -- sources = {
        --   default = {
        --     [";"] = { "yank" },
        --   },
        -- },
        enabled = true,
        keymap = {
          ["<CR>"] = { "accept", "fallback" },
          ["<Tab>"] = { "fallback" },
        },
        completion = {
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          menu = {
            auto_show = true,
          },
          ghost_text = {
            enabled = true,
          },
        },
      })
    end,
  },
}
