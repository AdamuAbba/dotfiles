return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "<leader>fm", "<cmd>Oil --float --preview<cr>", desc = "Open Oil" },
    },
    ---@module 'oil'
    ---@param opts oil.SetupOpts
    opts = function(_, opts)
      opts.default_file_explorer = true
      opts.columns = {
        -- "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      }
      opts.buf_options = {
        buflisted = false,
        bufhidden = "hide",
      }
      opts.win_options = {
        number = false,
        relativenumber = false,
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      }
      opts.delete_to_trash = true
      opts.skip_confirm_for_simple_edits = true
      opts.prompt_save_on_select_new_entry = true
      opts.cleanup_delay_ms = 2000
      opts.lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
      }
      opts.constrain_cursor = "editable"
      opts.watch_for_changes = false
      opts.keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = false,
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<Esc>"] = { "actions.close", mode = "n" },
        ["q"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = false,
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      }
      opts.use_default_keymaps = true
      opts.view_options = {
        show_hidden = true,
        natural_order = "fast",
        case_insensitive = false,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      }
      opts.float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        preview_split = "right",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      }
      opts.confirmation = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      }
      opts.progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      }
      opts.keymaps_help = {
        border = "rounded",
      }
      return opts
    end,
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  },
}
