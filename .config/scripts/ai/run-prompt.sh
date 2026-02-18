#!/usr/bin/env sh
set -u

PRESDIR="${XDG_CONFIG_HOME:-$HOME/.config}/.copilot/presets"
[ -d "$PRESDIR" ] || {
  printf 'presets not found: %s\n' "$PRESDIR" >&2
  exit 1
}

CHOICE="$(
  ls -1A "$PRESDIR" | fzf --tmux 55%,44% \
    --border-label ' Prompt Picker ' \
    --prompt '   ' \
    --input-border \
    --header-border
)" || exit 0
[ -n "$CHOICE" ] || exit 0
PROMPT="$(cat "$PRESDIR/$CHOICE")"

if ! command -v copilot >/dev/null 2>&1; then
  printf 'copilot: not found\n' >&2
  exit 2
fi

OUT="$(mktemp)" || exit 1
TMPMSG=""
trap 'rm -f "$OUT" "$TMPMSG"' EXIT INT TERM

# run copilot in background (bypass alias) and capture output
command copilot --allow-all-tools -p "$PROMPT" >"$OUT" 2>&1 &
PID=$!

# spinner while copilot runs
i=0
while kill -0 "$PID" 2>/dev/null; do
  case $((i % 4)) in
  0) c='|' ;;
  1) c='/' ;;
  2) c='-' ;;
  3) c='\' ;;
  esac
  printf '\r[%s] generating...' "$c"
  i=$((i + 1))
  sleep 0.12
done

wait "$PID" 2>/dev/null || true
printf '\r%*s\r' 40 ''

# strip extension and check
BASE="$(basename "$CHOICE")"
NAME="${BASE%%.*}"
if [ "$NAME" != "COMMIT-MESSAGE" ]; then
  exit 0
fi

# extract inner commit message from fenced ```gitcommit block
COMMIT_MSG="$(awk '/```gitcommit/ {p=1; next} p && /```/ {exit} p{print}' <"$OUT")"

if [ -z "$COMMIT_MSG" ]; then
  printf 'no commit message found; raw output:\n\n' >&2
  sed -n '1,200p' "$OUT" >&2
  exit 3
fi

printf '%s\n\n' "$COMMIT_MSG"

# confirm
printf 'Accept commit message and open editor for commit? [y/N] '
IFS= read -r ANSWER
case "$ANSWER" in
y | Y | yes | YES)
  # copy to clipboard (macOS pbcopy preferred)
  if command -v pbcopy >/dev/null 2>&1; then
    printf '%s' "$COMMIT_MSG" | pbcopy
  elif command -v wl-copy >/dev/null 2>&1; then
    printf '%s' "$COMMIT_MSG" | wl-copy
  elif command -v xclip >/dev/null 2>&1; then
    printf '%s' "$COMMIT_MSG" | xclip -selection clipboard
  else
    printf 'no clipboard utility found; skipping copy\n' >&2
  fi

  # prefill editor by using -F with --edit so editor opens with message
  TMPMSG="$(mktemp)" || exit 1
  printf '%s\n' "$COMMIT_MSG" >"$TMPMSG"
  tmux display-popup -E -w 80% -h 80% -T "Git Commit" -d "#{pane_current_path}" git commit --edit --signoff -F "$TMPMSG"
  ;;
*)
  printf 'Cancelled.\n'
  exit 0
  ;;
esac
