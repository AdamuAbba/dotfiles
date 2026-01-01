export BAT_THEME="Dracula"
export MANPAGER="bat -plman"
alias bathelp='bat --plain --language=help'

help() {
  if [ $# -eq 0 ]; then
    printf '%s\n' "usage: help <command> [subcommand ...]" >&2
    return 1
  fi
  cmd=$1; shift

  # try --help
  if command -v "$cmd" >/dev/null 2>&1 && "$cmd" "$@" --help >/dev/null 2>&1; then
    "$cmd" "$@" --help 2>&1 | bat --plain --language=help --style=plain
    return
  fi

  # try -h and check if output looks like help
  help_out=$("$cmd" "$@" -h 2>&1) || true
  if printf '%s' "$help_out" | grep -Ei '(^|\b)(usage|help|options|examples|commands|synopsis)\b' >/dev/null 2>&1; then
    printf '%s\n' "$help_out" | bat --plain --language=help --style=plain
    return
  fi

  # fallback to man
  if man "$cmd" >/dev/null 2>&1; then
    man "$cmd" | col -bx | bat --language=man --style=plain
    return
  fi

  # final fallback: show whatever -h produced
  printf '%s\n' "$help_out" | bat --plain --language=help --style=plain
}
