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
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "models/gemini-2.5-flash",
              },
            },
            env = {
              api_key = "cmd: security find-generic-password -a $USER -s gemini_api_key -w 2>/dev/null",
            },
          })
        end,
      },
      display = {
        chat = {
          show_header_separator = false,
          separator = "-",
          show_context = true,
          show_settings = false,
          show_token_count = true,
          start_in_insert_mode = true,
          window = {
            layout = "float",
            position = "right",
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
