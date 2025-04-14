return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    opts = {
      italic_comment = true,
      lualine_bg_color = "#282A36",
      overrides = {
        CursorColumn = { bg = "#44475a" },
        CursorLine = { bg = "#44475a" },
        StatusLine = { bg = "white" },
        Visual = { bg = "#BD93F9", fg = "black" },

        --============================================= Bufferline overrides here =============================================
        BufferLineFill = { bg = "#282A36" },
        BufferLineBackground = { bg = "#282A36" },

        --============================================= File Icons =============================================
        --inactive
        BufferLineMiniIconsAzure = { bg = "#282A36" },
        BufferLineMiniIconsGrey = { bg = "#282A36" },
        BufferLineMiniIconsYellow = { bg = "#282A36" },
        --active
        BufferLineMiniIconsAzureSelected = { bg = "#8265AB", fg = "#A4FFFF" },
        BufferLineMiniIconsYellowSelected = { bg = "#8265AB", fg = "#F1FA8C" },
        BufferLineMiniIconsGraySelected = { bg = "#8265AB", fg = "#F8F8F2" },

        --============================================= Close Button =============================================
        --inactive
        BufferLineCloseButton = { bg = "#282A36" },
        --active
        BufferLineCloseButtonSelected = { bg = "#8265AB" },

        --============================================= Separator =============================================
        --inactive
        BufferLineSeparator = { fg = "#282A36" },
        --active
        BufferLineSeparatorSelected = { fg = "#282A36" },

        --============================================= buffer container =============================================
        --inactive
        BufferLineBufferVisible = {
          fg = "#282A36",
          bg = "#282A36",
        },
        --active
        BufferLineBufferSelected = {
          bg = "#8265AB",
        },
      },
    },
    config = true,
  },
}
