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
        BlinkCmpMenu = { bg = theme_colors.background },
        BlinkCmpLabel = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
        BlinkCmpMenuSelection = { fg = theme_colors.black, bg = theme_colors.purple, bold = true },
        BlinkCmpSignatureHelpBorder = { fg = theme_colors.green, bg = theme_colors.background },
        BlinkCmpKind = { bg = theme_colors.background },

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
        BufferLineBufferVisible = { bg = theme_colors.background, fg = theme_colors.white, bold = true },
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
        BufferLineModifiedSelected = { bg = theme_colors.purple, fg = theme_colors.yellow, bold = true },
        BufferLineBufferSelected = { bg = theme_colors.purple, fg = theme_colors.black, bold = true },
        -- Diagnostics
        BufferLineDiagnosticSelected = { bg = theme_colors.purple, fg = theme_colors.black, bold = true },
        --Error
        BufferLineErrorSelected = { bg = theme_colors.purple, fg = theme_colors.red, bold = true },
        BufferLineErrorDiagnosticSelected = { bg = theme_colors.purple, fg = theme_colors.red, bold = true },
        --Warning
        BufferLineWarningSelected = { bg = theme_colors.purple, fg = theme_colors.yellow, bold = true },
        BufferLineWarningDiagnosticSelected = { bg = theme_colors.purple, fg = theme_colors.yellow, bold = true },
        --Hint
        BufferLineHintSelected = { bg = theme_colors.purple, fg = theme_colors.cyan, bold = true },
        BufferLineHintDiagnosticSelected = { bg = theme_colors.purple, fg = theme_colors.cyan, bold = true },
        --Info
        BufferLineInfoSelected = { bg = theme_colors.purple, fg = theme_colors.cyan, bold = true },
        BufferLineInfoDiagnosticSelected = { bg = theme_colors.purple, fg = theme_colors.cyan, bold = true },
        --============================================= Render markdown =============================================
        RenderMarkdownCodeBorder = { bg = theme_colors.purple, fg = theme_colors.white, bold = true },
        --H1
        RenderMarkdownH1 = { fg = theme_colors.white, bold = true },
        RenderMarkdownH1Bg = { bg = theme_colors.white, fg = theme_colors.black, bold = true },
        --H2
        RenderMarkdownH2 = { fg = theme_colors.pink, bold = true },
        RenderMarkdownH2Bg = { bg = theme_colors.pink, fg = theme_colors.white, bold = true },
        --H3
        RenderMarkdownH3 = { fg = theme_colors.cyan, bold = true },
        RenderMarkdownH3Bg = { bg = theme_colors.cyan, fg = theme_colors.black, bold = true },
        --============================================= Noice =============================================
        NoiceLspProgressTitle = { fg = theme_colors.green, bg = theme_colors.background, bold = true },
      },
    },
    config = true,
  },
}
