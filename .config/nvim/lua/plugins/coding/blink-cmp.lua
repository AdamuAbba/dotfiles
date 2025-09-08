return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-git",
      "moyiz/blink-emoji.nvim",
      "MahanRahmati/blink-nerdfont.nvim",
      "alexandre-abrioux/blink-cmp-npm.nvim",
      "archie-judd/blink-cmp-words",
      "bydlw98/blink-cmp-env",
      "ph1losof/ecolog.nvim",
      "disrupted/blink-cmp-conventional-commits",
    },
    opts = {
      keymap = {
        preset = "default",
        ["<Up>"] = false,
        ["<Down>"] = false,
        ["<C-e>"] = false,
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "fallback" },
      },
      sources = {
        default = { "conventional_commits", "ecolog", "git", "emoji", "npm", "dictionary", "env" },
        providers = {
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
            score_offset = 100,
            opts = {
              ignore = {},
              only_semantic_versions = true,
              only_latest_version = false,
            },
          },
          -- nerdfont = {
          --   module = "blink-nerdfont",
          --   name = "Nerd Fonts",
          --   score_offset = 15,
          --   opts = {
          --     insert = true,
          --   },
          --   should_show_items = function()
          --     return vim.tbl_contains({ "lua", "gitcommit", "markdown" }, vim.o.filetype)
          --   end,
          -- },
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
        },
      },
      completion = {
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

          -- LSPs can indicate when to show the completion window via trigger characters
          -- however, some LSPs (i.e. tsserver) return characters that would essentially
          -- always show the window. We block these by default.
          show_on_blocked_trigger_characters = { " ", "\n", "\t" },
          -- You can also block per filetype with a function:
          -- show_on_blocked_trigger_characters = function(ctx)
          --   if vim.bo.filetype == 'markdown' then return { ' ', '\n', '\t', '.', '/', '(', '[' } end
          --   return { ' ', '\n', '\t' }
          -- end,

          show_on_accept_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,

          -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
          -- the completion window when the cursor comes after a trigger character when
          -- entering insert mode/accepting an item
          show_on_x_blocked_trigger_characters = { "'", '"', "(" },
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
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          show_documentation = false,
        },
      },
      --CMDLINE specific config
      cmdline = {
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
      },
    },
  },
}
