vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/nvim-mini/mini.snippets",
})

local mini_snippets = require("mini.snippets")

-- empty placeholders insert nothing instead of the default "•" / "∎" markers
local my_i = function(snippet)
  return mini_snippets.default_insert(snippet, { empty_tabstop = "", empty_tabstop_final = "" })
end

mini_snippets.setup({
  -- snippets/<lang>.json from every 'runtimepath' dir: friendly-snippets and nvim/snippets/
  snippets = { mini_snippets.gen_loader.from_lang() },
  mappings = { jump_next = "<C-l>", jump_prev = "<C-h>" },
  expand = { insert = my_i },
})

-- serves snippets as completion items through the built-in LSP completion
mini_snippets.start_lsp_server()
