return {
  {
    "nvim-mini/mini.files",
    lazy = false,
    opts = function(_, opts)
      local icons = require("lib.icons")
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        use_as_default_explorer = true,
        permanent_delete = false,
      })
      opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
        close = "<esc>",
        go_in = "l",
        go_in_plus = "<CR>",
        go_out = "H",
        go_out_plus = "h",
        reset = "<BS>",
        reveal_cwd = ".",
        show_help = "g?",
        synchronize = "s",
        trim_left = "<",
        trim_right = ">",
      })
      opts.windows = vim.tbl_deep_extend("force", opts.windows or {}, {
        preview = true,
        width_focus = 30,
        width_preview = 80,
      })
      return opts
    end,
    config = function(_, opts)
      local mini_files = require("mini.files")
      local icons = require("lib.icons")

      mini_files.setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          local win_id = args.data.win_id
          local config = vim.api.nvim_win_get_config(win_id)
          config.border = icons.custom_border
          vim.api.nvim_win_set_config(win_id, config)
        end,
      })
    end,
  },
}
