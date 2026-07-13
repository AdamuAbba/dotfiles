return {
  {
    "nvim-mini/mini.snippets",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local mini_snippets = require("mini.snippets")

      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_stop = function() end -- by design, <esc> should not stop the session!
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_forward = function()
        ---@diagnostic disable-next-line: undefined-global
        return jump("next")
      end


      local my_i = function(snippet)
        return MiniSnippets.default_insert(snippet, { empty_tabstop = "", empty_tabstop_final = "" })
      end

      mini_snippets.setup({
        snippets = { mini_snippets.gen_loader.from_lang() },
        mappings = { jump_next = "<C-l>", jump_prev = "<C-h>" },
        expand = {
          select = function(snippets, insert)
            local select = expand_select_override or mini_snippets.default_select
            select(snippets, insert)
          end,
          insert = my_i,
        },
      })

      mini_snippets.start_lsp_server()
    end,
  },
}
