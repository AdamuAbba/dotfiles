---@diagnostic disable: missing-fields
return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    enabled = true,
    config = function(_, opts)
      local TS = require("nvim-treesitter-textobjects")
      TS.setup({
        select = vim.tbl_deep_extend("force", opts.select or {}, {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

            ["acm"] = { query = "@comment.outer", desc = "Select outer part of a comment" },

            -- works for javascript/typescript files (custom capture created in after/queries/ecma/textobjects.scm)
            ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
            ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
            ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
            ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

            ["acd"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["icd"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            ["alp"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["ilp"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

            ["am"] = { query = "@call.outer", desc = "Select outer part of a method call" },
            ["im"] = { query = "@call.inner", desc = "Select inner part of a method call" },

            ["acl"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["icl"] = { query = "@class.inner", desc = "Select inner part of a class" },

            ["art"] = { query = "@return.outer", desc = "Select outer part of a return" },
            ["irt"] = { query = "@return.inner", desc = "Select inner part of a return" },
          },
        }),

        move = vim.tbl_deep_extend("force", opts.move or {}, {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = { query = "@call.outer", desc = "Next method call start" },
            ["]rt"] = { query = "@return.outer", desc = "Next return start" },
            ["]f"] = { query = "@function.outer", desc = "Next function def start" },
            ["]cl"] = { query = "@class.outer", desc = "Next class start" },
            ["]cd"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]lp"] = { query = "@loop.outer", desc = "Next loop start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
            ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
            ["[r"] = { query = "@return.outer", desc = "prev return call start" },
            ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
            ["[c"] = { query = "@class.outer", desc = "Prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
            ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
            ["[C"] = { query = "@class.outer", desc = "Prev class end" },
            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
          },
        }),
      })
    end,
  },
}
