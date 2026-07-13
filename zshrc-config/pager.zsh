CONFIG_DIR="$HOME/.config"
SCRIPT_DIR="$CONFIG_DIR/scripts"

vcat() {
  if [ $# -eq 0 ] || [ "$1" = "-" ]; then
    "$SCRIPT_DIR/mac-os/view.sh" -
  else
    "$SCRIPT_DIR/mac-os/view.sh" "$@"
  fi
}
