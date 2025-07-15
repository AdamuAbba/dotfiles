local M = {}

M.background = os.getenv("DRACULA_BACKGROUND")
M.current_line = os.getenv("DRACULA_CURRENT_LINE")
M.selection = os.getenv("DRACULA_SELECTION")
M.foreground = os.getenv("DRACULA_FOREGROUND")
M.comment = os.getenv("DRACULA_COMMENT")
M.cyan = os.getenv("DRACULA_CYAN")
M.green = os.getenv("DRACULA_GREEN")
M.orange = os.getenv("DRACULA_ORANGE")
M.pink = os.getenv("DRACULA_PINK")
M.purple = os.getenv("DRACULA_PURPLE")
M.red = os.getenv("DRACULA_RED")
M.yellow = os.getenv("DRACULA_YELLOW")
M.white = os.getenv("DRACULA_WHITE")
M.black = os.getenv("DRACULA_BLACK")

return M
