return {
  {
    "nvim-mini/mini.snippets",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_stop = function() end -- by design, <esc> should not stop the session!
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_forward = function()
        ---@diagnostic disable-next-line: undefined-global
        return jump("next")
      end

      local mini_snippets = require("mini.snippets")

      local my_i = function(snippet)
        return MiniSnippets.default_insert(snippet, { empty_tabstop = "", empty_tabstop_final = "" })
      end

      return {
        snippets = { mini_snippets.gen_loader.from_lang() },
        mappings = { jump_next = "<C-l>", jump_prev = "<C-h>" },
        expand = {
          select = function(snippets, insert)
            local select = expand_select_override or MiniSnippets.default_select
            select(snippets, insert)
          end,
          insert = my_i,
        },
      }
    end,
  },
}
