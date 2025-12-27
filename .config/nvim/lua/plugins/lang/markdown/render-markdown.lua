return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    ---@param _ any
    ---@param opts render.md.UserConfig
    ft = { "copilot-chat" },
    opts = function(_, opts)
      table.insert(opts.file_types, "copilot-chat")
      opts.completions = vim.tbl_deep_extend("force", opts.completions or {}, {
        lsp = {
          enabled = true,
        },
        blink = { enabled = true },
      })
      opts.indent = vim.tbl_deep_extend("force", opts.indent or {}, {
        enabled = true,
        per_level = 2,
        skip_level = 1,
        skip_heading = false,
        icon = "|",
        priority = 0,
      })
      opts.code = vim.tbl_deep_extend("force", opts.code or {}, {
        enabled = true,
        conceal_delimiters = true,
        border = "thin",
        above = "_",
        below = "-",
        language_border = "█",
        language_left = "",
        highlight_language = "DiagnosticFloatingHint",
        language_right = "",
        language = true,
        position = "left",
        language_icon = true,
        language_name = true,
        language_info = true,
        sign = true,
        width = "block",
        right_pad = 1,
      })
      opts.heading = vim.tbl_deep_extend("force", opts.heading or {}, {
        sign = true,
        atx = true,
        setext = true,
        icons = {},
        border = true,
        enabled = true,
        border_virtual = false,
        above = "_",
        below = "-",
        signs = { "󰫎 " },
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
        width = "block",
      })
      opts.checkbox = vim.tbl_deep_extend("force", opts.checkbox or {}, {
        enabled = true,
        bullet = true,
        right_pad = 1,
      })
      return opts
    end,
  },
}
