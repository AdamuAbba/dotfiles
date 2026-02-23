local theme_colors = require("config.theme-colors")

local M = {}

M.groups = {
  -- Core
  CursorColumn = { bg = theme_colors.gray },
  CursorLine = { bg = theme_colors.gray },
  StatusLine = { bg = theme_colors.background },
  Visual = { fg = theme_colors.black, bg = theme_colors.pink },
  WinBar = { bg = theme_colors.background },
  WinBarNC = { bg = theme_colors.background },
  VertSplit = { fg = theme_colors.white, bg = theme_colors.background },
  WinSeparator = { fg = theme_colors.white, bg = theme_colors.background },
  Normal = { bg = theme_colors.background },
  NormalNC = { bg = theme_colors.background },
  SignColumn = { bg = theme_colors.background },
  FoldColumn = { bg = theme_colors.background },
  LineNr = { bg = theme_colors.background },
  CursorLineNr = { bg = theme_colors.background },
  EndOfBuffer = { bg = theme_colors.background },
  StatusLineNC = { bg = theme_colors.background },

  -- Mini Files / Mini Pick
  MiniFilesNormal = { bg = theme_colors.background },
  MiniFilesBorder = { fg = theme_colors.white, bg = theme_colors.background },
  MiniFilesCursorLine = { fg = theme_colors.white, bg = theme_colors.green, bold = true },
  MiniPickMatchCurrent = { fg = theme_colors.white, bg = theme_colors.green, bold = true },
  MiniPickMatchMarked = { fg = theme_colors.white, bg = theme_colors.green, bold = true },
  MiniPickBorderText = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  MiniPickPrompt = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  MiniFilesTitle = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  MiniFilesTitleFocused = { fg = theme_colors.white, bg = theme_colors.background, bold = true },

  -- Lualine
  lualine_transitional_lualine_a_normal_to_StatusLine = { fg = theme_colors.cyan, bg = theme_colors.background },
  lualine_transitional_lualine_a_insert_to_StatusLine = { fg = theme_colors.cyan, bg = theme_colors.background },

  -- BlinkCmp
  BlinkCmpDocBorder = { fg = theme_colors.white, bg = theme_colors.background },
  BlinkCmpMenuBorder = { fg = theme_colors.white, bg = theme_colors.background },
  BlinkCmpMenu = { bg = theme_colors.background },
  BlinkCmpLabel = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  BlinkCmpMenuSelection = { fg = theme_colors.white, bg = theme_colors.green, bold = true },
  BlinkCmpSignatureHelpBorder = { fg = theme_colors.white, bg = theme_colors.background },
  BlinkCmpKind = { bg = theme_colors.background },
  BlinkCmpKindRipgrepRipgrep = { fg = theme_colors.yellow, bg = theme_colors.background, bold = true },

  -- LSP / Diagnostics
  FloatBorder = { fg = theme_colors.white, bg = theme_colors.background },
  NormalFloat = { bg = theme_colors.background },
  DiagnosticFloatingError = { fg = theme_colors.red },
  DiagnosticFloatingWarn = { fg = theme_colors.orange },
  DiagnosticFloatingInfo = { fg = theme_colors.cyan },
  DiagnosticFloatingHint = { fg = theme_colors.purple },

  -- WhichKey
  WhichKeyBorder = { fg = theme_colors.white, bg = theme_colors.background },
  WhichKeyTitle = { fg = theme_colors.white, bg = theme_colors.background },
  WhichKeySeparator = { fg = theme_colors.white, bg = theme_colors.background },

  -- Snacks
  SnacksPickerFile = { bg = theme_colors.background },
  SnacksPickerInput = { bg = theme_colors.background },
  SnacksPickerList = { bg = theme_colors.background },
  SnacksPickerPreview = { bg = theme_colors.background },
  SnacksPickerBox = { bg = theme_colors.background },
  SnacksPickerInputBorder = { fg = theme_colors.white, bg = theme_colors.background },
  SnacksPickerListBorder = { fg = theme_colors.white, bg = theme_colors.background },
  SnacksPickerPreviewBorder = { fg = theme_colors.white, bg = theme_colors.background },
  SnacksPickerBoxBorder = { fg = theme_colors.white, bg = theme_colors.background },
  SnacksPickerBorder = { fg = theme_colors.white, bg = theme_colors.background },
  SnacksIndentScope = { fg = theme_colors.green },
  SnacksIndent = { fg = theme_colors.gray },
  SnacksNotifierHistoryTitle = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  SnacksNotifierTitleTrace = { fg = theme_colors.white, bg = theme_colors.background, bold = true },

  -- Render Markdown
  RenderMarkdownCodeBorder = { bg = theme_colors.current_line, bold = true },
  RenderMarkdownCode = { bg = theme_colors.gray, bold = true },
  RenderMarkdownH1 = { fg = theme_colors.white, bold = true },
  RenderMarkdownH1Bg = { bg = theme_colors.white, fg = theme_colors.black, bold = true },
  RenderMarkdownH2 = { fg = theme_colors.pink, bold = true },
  RenderMarkdownH2Bg = { bg = theme_colors.pink, fg = theme_colors.white, bold = true },
  RenderMarkdownH3 = { fg = theme_colors.cyan, bold = true },
  RenderMarkdownH3Bg = { bg = theme_colors.cyan, fg = theme_colors.black, bold = true },
  RenderMarkdownH4 = { fg = theme_colors.orange, bold = true },
  RenderMarkdownH4Bg = { bg = theme_colors.orange, fg = theme_colors.black, bold = true },

  -- Noice
  NoiceLspProgressTitle = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupBorderSearch = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupTitleSearch = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupBorderCmdline = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupTitleCmdline = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupBorderInput = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupTitleInput = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupBorder = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupBorderFilter = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupTitleFilter = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupTitle = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupBorderCalculator = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupTitleCalculator = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupBorderLua = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupTitleLua = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupBorderHelp = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupTitleHelp = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupBorderIncRename = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlinePopupTitleIncRename = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlineIcon = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlineIconCmdline = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlineIconFilter = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlineIconLua = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlineIconCalculator = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  NoiceCmdlineIconSearch = { fg = theme_colors.white, bg = theme_colors.background, bold = true },

  -- Telescope
  TelescopePromptBorder = { fg = theme_colors.white, bg = theme_colors.background },
  TelescopeResultsBorder = { fg = theme_colors.white, bg = theme_colors.background },
  TelescopePreviewBorder = { fg = theme_colors.white, bg = theme_colors.background },
  TelescopeSelection = { fg = theme_colors.black, bg = theme_colors.green, bold = true },
  TelescopeTitle = { fg = theme_colors.white, bg = theme_colors.background },

  -- Lazy
  LazyButton = { bg = theme_colors.background, bold = true },
  LazyButtonActive = { fg = theme_colors.black, bg = theme_colors.green, bold = true },

  -- Pmenu
  Pmenu = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  PmenuSel = { fg = theme_colors.black, bg = theme_colors.green, bold = true },

  -- Git Conflict
  GitConflictCurrentLabel = { fg = theme_colors.black, bg = theme_colors.cyan, bold = true },
  GitConflictCurrent = { bg = theme_colors.cyan, bold = true },
  GitConflictIncomingLabel = { fg = theme_colors.white, bg = theme_colors.green, bold = true },
  GitConflictIncoming = { bg = theme_colors.white, bold = true },
}

function M:apply()
  for name, opts in pairs(self.groups) do
    vim.api.nvim_set_hl(0, name, opts)
  end
end

return M
