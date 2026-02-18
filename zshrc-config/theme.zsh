export THEME_FONT="Iosevka NF"
# https://github.com/dracula/dracula-theme#color-palette
#============================================ Dracula color palette================================================
# export DRACULA_BACKGROUND=#282a36
export DRACULA_BACKGROUND=#000000
export DRACULA_CURRENT_LINE=#44475a
export DRACULA_SELECTION=#44475a
export DRACULA_FOREGROUND=#f8f8f2
export DRACULA_COMMENT=#6272a4
export DRACULA_CYAN=#8be9fd
# export DRACULA_GREEN=#50fa7b
export DRACULA_GREEN="#404F3C"
export DRACULA_ORANGE=#ffb86c
export DRACULA_PINK=#ff79c6
export DRACULA_PURPLE=#bd93f9
export DRACULA_RED=#ff5555
export DRACULA_YELLOW=#f1fa8c
export DRACULA_WHITE=#ffffff
export DRACULA_BLACK=#000000
export DRACULA_GRAY=#313243

#============================================= 256-color numbers =============================================
# - zle_highlight only supports:
#   - 256-color numbers (0–255)
#   - Named colors (red, blue, etc.)

# Convert hex →  nearest 256-color value
hex_to_256() {
  local hex=${1#\#}
  local r=$((16#${hex:0:2}))
  local g=$((16#${hex:2:2}))
  local b=$((16#${hex:4:2}))

  printf '%d\n' $((16 + 36 * (r / 51) + 6 * (g / 51) + (b / 51)))
}
