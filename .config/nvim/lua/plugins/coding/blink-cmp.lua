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
      "alexandre-abrioux/blink-cmp-npm.nvim",
      "disrupted/blink-cmp-conventional-commits",
      {
        "bydlw98/blink-cmp-sshconfig",
        build = "make",
      },
      {
        "mikavilpas/blink-ripgrep.nvim",
        version = "*",
      },
    },
    ---@module 'blink.cmp'
    ---@param _ any
    ---@param opts blink.cmp.Config
    opts = function(_, opts)
      local custom_border = require("lib.icons").custom_border

      opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
        ["<Up>"] = false,
        ["<Down>"] = false,
        ["<Tab>"] = {},
        ["<C-e>"] = false,
        ["<CR>"] = { "accept", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      })
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        ---@diagnostic disable-next-line: param-type-mismatch
        default = vim.list_extend(opts.sources.default or {}, {
          "ecolog",
          "npm",
          "ripgrep",
          "conventional_commits",
          "git",
          "emoji",
          "dictionary",
          "env",
          "sshconfig",
        }),
        providers = vim.tbl_deep_extend("force", opts.sources.providers or {}, {
          ecolog = {
            name = "ecolog",
            module = "ecolog.integrations.cmp.blink_cmp",
          },
          ripgrep = {
            module = "blink-ripgrep",
            score_offset = -10,
            name = "Ripgrep",
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              project_root_marker = vim.fs.root(0, ".git") or vim.fn.getcwd(),
              transform_items = function(_, items)
                for _, item in ipairs(items) do
                  item.labelDetails = {
                    description = "(rg)",
                  }
                end
                return items
              end,
            },
          },
          sshconfig = {
            name = "SshConfig",
            module = "blink-cmp-sshconfig",
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
          border = custom_border,
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
            border = custom_border,
          },
        },
      })
      opts.signature = vim.tbl_deep_extend("force", opts.signature or {}, {
        enabled = true,
        window = {
          border = custom_border,
          show_documentation = false,
        },
      })
      --CMDLINE specific config
      opts.cmdline = vim.tbl_deep_extend("force", opts.cmdline or {}, {
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
      return opts
    end,
  },
}
