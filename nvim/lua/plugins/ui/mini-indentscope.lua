return {
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
    version = false,
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 100,
          predicate = function(scope)
            return not scope.body.is_incomplete
          end,
          priority = 2,
        },

        mappings = {
          object_scope = "",
          object_scope_with_border = "",
          goto_top = "",
          goto_bottom = "",
        },

        options = {
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
