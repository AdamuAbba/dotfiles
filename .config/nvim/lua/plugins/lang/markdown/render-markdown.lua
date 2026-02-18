return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "snacks_notif_history" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    ---@param _ any
    ---@param opts render.md.UserConfig
    opts = function(_, opts)
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
      opts.pipe_table = vim.tbl_deep_extend("force", opts.pipe_table or {}, {
        enabled = true,
        preset = "round",
      })
      opts.code = vim.tbl_deep_extend("force", opts.code or {}, {
        enabled = true,
        border = "thick",
        above = "_",
        below = "-",
        style = "full",
        language_border = "█",
        language_left = "",
        language_right = "",
        language = true,
        position = "left",
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
