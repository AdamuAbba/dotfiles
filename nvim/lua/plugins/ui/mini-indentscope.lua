return {
  {
    "nvim-mini/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 100,
          predicate = function(scope)
            return not scope.body.is_incomplete
          end,

          -- Symbol priority. Increase to display on top of more symbols.
          priority = 2,
        },

        mappings = {
          object_scope = "",
          object_scope_with_border = "",
          goto_top = "",
          goto_bottom = "",
        },

        -- Options which control scope computation
        options = {
          -- Type of scope's border: which line(s) with smaller indent to
          -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
          border = "both",
          indent_at_cursor = true,
          n_lines = 10000,
          try_as_border = false,
        },
        symbol = "╎",
      })
    end,
  },
}
