return {
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "Kaiser-Yang/blink-cmp-git",
        "moyiz/blink-emoji.nvim",
        "MahanRahmati/blink-nerdfont.nvim",
        "alexandre-abrioux/blink-cmp-npm.nvim",
        "archie-judd/blink-cmp-words",
        "bydlw98/blink-cmp-env",
        "ph1losof/ecolog.nvim",
        "disrupted/blink-cmp-conventional-commits",
      },
    },
    opts = {
      sources = {
        default = { "conventional_commits", "ecolog", "git", "emoji", "nerdfont", "npm", "dictionary", "env" },
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
            -- optional - make blink-cmp-npm completions top priority (see `:h blink.cmp`)
            score_offset = 100,
            opts = {
              ignore = {},
              only_semantic_versions = true,
              only_latest_version = false,
            },
          },
          nerdfont = {
            module = "blink-nerdfont",
            name = "Nerd Fonts",
            score_offset = 15,
            opts = {
              insert = true,
              ---@type string|table|fun():table
              trigger = function()
                return { ":" }
              end,
            },
            should_show_items = function()
              return vim.tbl_contains({ "lua", "gitcommit", "markdown" }, vim.o.filetype)
            end,
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = {
              insert = true,
              ---@type string|table|fun():table
              trigger = function()
                return { ":" }
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
      cmdline = {
        enabled = true,
        completion = {
          menu = {
            auto_show = true,
          },
          ghost_text = {
            enabled = true,
          },
        },
      },
      completion = {
        menu = { border = "rounded" },
        documentation = { window = { border = "rounded" } },
      },
      signature = { window = { border = "rounded" } },
    },
  },
}
