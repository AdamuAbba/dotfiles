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
        --============================================= BlinkCmp overrides=============================================
        BlinkCmpDocBorder = { fg = theme_colors.green, bg = theme_colors.background },
        BlinkCmpMenuBorder = { fg = theme_colors.green, bg = theme_colors.background },
        BlinkCmpSignatureHelpBorder = { fg = theme_colors.green, bg = theme_colors.background },

        --============================================= Lsp window overrides =============================================
        FloatBorder = { fg = theme_colors.green, bg = theme_colors.background },
        NormalFloat = { bg = theme_colors.background },
        DiagnosticFloatingError = { fg = theme_colors.red },
        DiagnosticFloatingWarn = { fg = theme_colors.orange },
        DiagnosticFloatingInfo = { fg = theme_colors.cyan },
        DiagnosticFloatingHint = { fg = theme_colors.purple },
        --============================================= Whichkey overrides=============================================
        WhichKeyBorder = { fg = theme_colors.green, bg = theme_colors.background },

        --============================================= Snacks overrides=============================================
        SnacksPickerFile = { bg = theme_colors.background },
        SnacksPickerInput = { bg = theme_colors.background },
        SnacksPickerList = { bg = theme_colors.background },
        SnacksPickerPreview = { bg = theme_colors.background },
        SnacksPickerBox = { bg = theme_colors.background },
        SnacksPickerInputBorder = { fg = theme_colors.green, bg = theme_colors.background },
        SnacksPickerListBorder = { fg = theme_colors.green, bg = theme_colors.background },
        SnacksPickerPreviewBorder = { fg = theme_colors.green, bg = theme_colors.background },
        SnacksPickerBoxBorder = { fg = theme_colors.green, bg = theme_colors.background },
        SnacksPickerBorder = { fg = theme_colors.green, bg = theme_colors.background },
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
