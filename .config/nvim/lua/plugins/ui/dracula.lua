local theme_colors = require("config/theme-colors")

return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    opts = {
      colors = {
        bg = theme_colors.background,
      },
      italic_comment = true,
      lualine_bg_color = theme_colors.background,
      overrides = {
        CursorColumn = { bg = theme_colors.selection },
        CursorLine = { bg = theme_colors.selection },
        StatusLine = { bg = theme_colors.white },
        Visual = { bg = theme_colors.purple, fg = theme_colors.black },
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
        --======================== inactive =================
        BufferLineDiagnostic = { bg = theme_colors.background },
        BufferLineMiniIconsAzure = { bg = theme_colors.background, fg = theme_colors.cyan },
        BufferLineMiniIconsGrey = { bg = theme_colors.background, fg = theme_colors.foreground },
        BufferLineMiniIconsGray = { bg = theme_colors.background, fg = theme_colors.foreground },
        BufferLineMiniIconsYellow = { bg = theme_colors.background, fg = theme_colors.yellow },
        BufferLineMiniIconsOrange = { bg = theme_colors.background, fg = theme_colors.orange },
        BufferLineMiniIconsGreen = { bg = theme_colors.background, fg = theme_colors.green },
        BufferLineMiniIconsBlue = { bg = theme_colors.background, fg = theme_colors.cyan },
        BufferLineCloseButton = { bg = theme_colors.background, fg = theme_colors.red },
        BufferLineSeparator = { fg = theme_colors.background },
        BufferLineBufferVisible = { fg = theme_colors.background, bg = theme_colors.background },
        BufferLineModifiedVisible = { fg = theme_colors.white, bg = theme_colors.background },
        BufferLineModified = { bg = theme_colors.background, fg = theme_colors.yellow },
        -- Diagnostics
        BufferLineErrorDiagnostic = { bg = theme_colors.background, fg = theme_colors.red },
        BufferLineError = { bg = theme_colors.background, fg = theme_colors.white },
        BufferLineWarning = { bg = theme_colors.background, fg = theme_colors.white },
        BufferLineWarningDiagnostic = { bg = theme_colors.background, fg = theme_colors.yellow },
        BufferLineDiagnosticVisible = { fg = theme_colors.white, bg = theme_colors.background },
        --======================= active ===================
        BufferLineMiniIconsAzureSelected = { bg = theme_colors.purple, fg = theme_colors.cyan },
        BufferLineMiniIconsYellowSelected = { bg = theme_colors.purple, fg = theme_colors.yellow },
        BufferLineMiniIconsGraySelected = { bg = theme_colors.purple, fg = theme_colors.foreground },
        BufferLineMiniIconsGreySelected = { bg = theme_colors.purple, fg = theme_colors.foreground },
        BufferLineMiniIconsOrangeSelected = { bg = theme_colors.purple, fg = theme_colors.orange },
        BufferLineMiniIconsGreenSelected = { bg = theme_colors.purple, fg = theme_colors.green },
        BufferLineMiniIconsBlueSelected = { bg = theme_colors.purple, fg = theme_colors.cyan },
        BufferLineCloseButtonSelected = { bg = theme_colors.purple, fg = theme_colors.red },
        BufferLineSeparatorSelected = { fg = theme_colors.background },
        BufferLineModifiedSelected = { bg = theme_colors.purple, fg = theme_colors.yellow },
        BufferLineBufferSelected = { bg = theme_colors.purple },
        -- Diagnostics
        BufferLineDiagnosticSelected = { bg = theme_colors.purple },
        BufferLineErrorDiagnosticSelected = { bg = theme_colors.purple, fg = theme_colors.red },
        BufferLineWarningDiagnosticSelected = { bg = theme_colors.purple, fg = theme_colors.yellow },
        BufferLineErrorSelected = { bg = theme_colors.purple },
        BufferLineWarningSelected = { bg = theme_colors.purple },
      },
    },
    config = true,
  },
}
