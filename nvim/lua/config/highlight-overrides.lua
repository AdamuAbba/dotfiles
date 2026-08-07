local theme_colors = require("config.theme-colors")

local M = {}

M.groups = {
  -- Core
  CursorColumn = { bg = theme_colors.gray },
  CursorLine = { bg = theme_colors.gray },
  StatusLine = { bg = theme_colors.background },
  Visual = { bg = theme_colors.gray },
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
  FloatFooter = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  FloatTitle = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  -- quickfixlist
  QuickFixLine = { fg = theme_colors.green, bg = theme_colors.background, bold = true },
  qfFileName = { fg = theme_colors.white, bg = theme_colors.background },
  qfLineNr = { fg = theme_colors.white, bg = theme_colors.background },
  qfText = { fg = theme_colors.white, bg = theme_colors.background },

  -- oil
  OilDir = { bg = theme_colors.background, bold = true },

  -- nvim icons
  NvimTreeRootFolder = { fg = theme_colors.steel_gray, bg = theme_colors.background },

  --Mini Indentscope
  MiniIndentscopeSymbol = { fg = theme_colors.steel_gray, bg = theme_colors.background },

  --Mini Pick
  MiniPickMatchCurrent = { fg = "None", bg = theme_colors.gray, bold = true },
  MiniPickMatchMarked = { fg = theme_colors.white, bg = theme_colors.green, bold = true },
  MiniPickBorderText = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  MiniPickPrompt = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  MiniPickHeader = { fg = theme_colors.white, bg = theme_colors.background },
  MiniPickMatchRanges = { fg = theme_colors.green, bg = theme_colors.background, bold = true },
  MiniPickNormal = { fg = theme_colors.white, bg = theme_colors.background },

  --Mini Icons
  MiniIcons = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  MiniIconsAzure = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  MiniIconsRed = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  MiniIconsOrange = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  MiniIconsGreen = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  MiniIconsBlue = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  MiniIconsPurple = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  MiniIconsCyan = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  MiniIconsYellow = { fg = theme_colors.steel_gray, bg = theme_colors.background },

  -- Lualine
  lualine_transitional_lualine_a_normal_to_StatusLine = { fg = theme_colors.cyan, bg = theme_colors.background },
  lualine_transitional_lualine_a_insert_to_StatusLine = { fg = theme_colors.cyan, bg = theme_colors.background },

  -- BlinkCmp
  BlinkCmpDocBorder = { fg = theme_colors.white, bg = theme_colors.background },
  BlinkCmpMenuBorder = { fg = theme_colors.white, bg = theme_colors.background },
  BlinkCmpMenu = { bg = theme_colors.background },
  BlinkCmpLabel = { fg = theme_colors.white, bg = theme_colors.background, bold = true },
  BlinkCmpMenuSelection = { fg = theme_colors.white, bg = theme_colors.gray, bold = true },
  BlinkCmpSignatureHelpBorder = { fg = theme_colors.white, bg = theme_colors.background },
  BlinkCmpKind = { bg = theme_colors.background },
  BlinkCmpKindRipgrepRipgrep = { fg = theme_colors.yellow, bg = theme_colors.background, bold = true },

  -- indent-blankline
  IndentLineCurrent = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  IblIndent = { fg = theme_colors.steel_gray, bg = theme_colors.background },
  IndentLine = { fg = theme_colors.steel_gray, bg = theme_colors.background },

  -- LSP / Diagnostics
  FloatBorder = { fg = theme_colors.white, bg = theme_colors.background },
  NormalFloat = { fg = theme_colors.white, bg = theme_colors.background },
  DiagnosticFloatingError = { fg = theme_colors.red },
  DiagnosticFloatingWarn = { fg = theme_colors.orange },
  DiagnosticFloatingInfo = { fg = theme_colors.cyan },
  DiagnosticFloatingHint = { fg = theme_colors.purple },
  LspInlayHint = { fg = "#79675e", bg = "none" },

  -- WhichKey
  WhichKeyBorder = { fg = theme_colors.white, bg = theme_colors.background },
  WhichKeyTitle = { fg = theme_colors.white, bg = theme_colors.background },
  WhichKeySeparator = { fg = theme_colors.white, bg = theme_colors.background },
  WhichKeyValue = { fg = theme_colors.white, bg = theme_colors.background },
  WhichKeyGroup = { fg = theme_colors.white, bg = theme_colors.background },

  -- Render Markdown
  RenderMarkdownCodeBorder = { bg = theme_colors.dark_gray, bold = true },
  RenderMarkdownCode = { bg = theme_colors.dark_gray, bold = true },
  RenderMarkdownChecked = { fg = theme_colors.green, bg = theme_colors.black, bold = true },
  RenderMarkdownH1 = { fg = theme_colors.white, bold = true },
  RenderMarkdownH1Bg = { bg = theme_colors.white, fg = theme_colors.black, bold = true },
  RenderMarkdownH2 = { fg = theme_colors.pink, bold = true },
  RenderMarkdownH2Bg = { bg = theme_colors.pink, fg = theme_colors.white, bold = true },
  RenderMarkdownH3 = { fg = theme_colors.cyan, bold = true },
  RenderMarkdownH3Bg = { bg = theme_colors.cyan, fg = theme_colors.black, bold = true },
  RenderMarkdownH4 = { fg = theme_colors.orange, bold = true },
  RenderMarkdownH4Bg = { bg = theme_colors.orange, fg = theme_colors.black, bold = true },

  -- Telescope
  TelescopePromptBorder = { fg = theme_colors.white, bg = theme_colors.background },
  TelescopeResultsBorder = { fg = theme_colors.white, bg = theme_colors.background },
  TelescopePreviewBorder = { fg = theme_colors.white, bg = theme_colors.background },
  TelescopeSelection = { fg = theme_colors.black, bg = theme_colors.gray, bold = true },
  TelescopeTitle = { fg = theme_colors.white, bg = theme_colors.background },

  -- Lazy
  LazyButton = { bg = theme_colors.background, bold = true },
  LazyButtonActive = { fg = theme_colors.white, bg = theme_colors.gray, bold = true },

  -- Pmenu
  Pmenu = { fg = theme_colors.white, bg = theme_colors.background },
  PmenuSel = { fg = "None", bg = theme_colors.gray, bold = true },
  PmenuMatch = { fg = theme_colors.green, bg = theme_colors.background, bold = true },
  PmenuMatchSel = { fg = "None", bg = theme_colors.gray, bold = true },

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
