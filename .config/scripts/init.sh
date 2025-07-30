#!/usr/bin/env sh

# source all scripts in this directory
# shellcheck source=/dev/null
for f in "$HOME/.config/scripts/mac-os/"*; do
  [ -f "$f" ] || continue
  [ -x "$f" ] || chmod +x "$f"
  . "$f"
done
