local theme_colors = require("config/theme-colors")

return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    opts = {
      italic_comment = true,
      lualine_bg_color = theme_colors.background,
      overrides = {
        CursorColumn = { bg = "#44475a" },
        CursorLine = { bg = "#44475a" },
        StatusLine = { bg = "white" },
        Visual = { bg = theme_colors.purple, fg = "black" },
        --============================================= Whichkey overrides=============================================
        WhichKeyBorder = { fg = theme_colors.green, bg = "NONE" },
        --============================================= Snacks overrides=============================================
        SnacksPickerInputBorder = { fg = theme_colors.green, bg = "NONE" },
        SnacksPickerListBorder = { fg = theme_colors.green, bg = "NONE" },
        SnacksPickerPreviewBorder = { fg = theme_colors.green, bg = "NONE" },
        SnacksPickerBoxBorder = { fg = theme_colors.green, bg = "NONE" },
        SnacksPickerBorder = { fg = theme_colors.green, bg = "NONE" },
        --============================================= Bufferline overrides here =============================================
        BufferLineFill = { bg = theme_colors.background },
        BufferLineBackground = { bg = theme_colors.background },

        --============================================= File Icons =============================================
        --inactive
        BufferLineMiniIconsAzure = { bg = theme_colors.background },
        BufferLineMiniIconsGrey = { bg = theme_colors.background },
        BufferLineMiniIconsYellow = { bg = theme_colors.background },
        BufferLineMiniIconsOrange = { bg = theme_colors.background },
        BufferLineMiniIconsGreen = { bg = theme_colors.background },
        --active
        BufferLineMiniIconsAzureSelected = { bg = theme_colors.purple, fg = theme_colors.cyan },
        BufferLineMiniIconsYellowSelected = { bg = theme_colors.purple, fg = theme_colors.yellow },
        BufferLineMiniIconsGraySelected = { bg = theme_colors.purple, fg = theme_colors.foreground },
        BufferLineMiniIconsGreySelected = { bg = theme_colors.purple, fg = theme_colors.foreground },
        BufferLineMiniIconsOrangeSelected = { bg = theme_colors.purple, fg = theme_colors.orange },
        BufferLineMiniIconsGreenSelected = { bg = theme_colors.purple, fg = theme_colors.green },

        --============================================= Close Button =============================================
        --inactive
        BufferLineCloseButton = { bg = theme_colors.background },
        --active
        BufferLineCloseButtonSelected = { bg = theme_colors.purple },

        --============================================= Separator =============================================
        --inactive
        BufferLineSeparator = { fg = theme_colors.background },
        --active
        BufferLineSeparatorSelected = { fg = theme_colors.background },

        --============================================= buffer container =============================================
        --inactive
        BufferLineBufferVisible = {
          fg = theme_colors.background,
          bg = theme_colors.background,
        },
        --active
        BufferLineBufferSelected = {
          bg = theme_colors.purple,
        },
      },
    },
    config = true,
  },
}
