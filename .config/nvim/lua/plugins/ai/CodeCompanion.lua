return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      ---@module "codecompanion"
      ---@diagnostic disable-next-line: undefined-doc-name
      ---@type CodeCompanion.Config
      display = {
        chat = {
          show_header_separator = false,
          separator = "-",
          show_context = true,
          show_settings = true,
          show_token_count = true,
          start_in_insert_mode = false,
          window = {
            layout = "float", -- float|vertical|horizontal|buffer
            position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
            border = "rounded",
            height = 0.95,
            width = 0.45,
            row = math.floor((vim.o.lines * 0.2) / 2), -- centers vertically
            col = math.floor(vim.o.columns * (1 - 0.45)),
            relative = "editor",
            full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
            sticky = false, -- when set to true and `layout` is not `"buffer"`, the chat buffer will remain opened when switching tabs
            auto_scroll = true,
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = "no",
              spell = false,
              wrap = true,
            },
          },
        },
      },
    },
  },
}
