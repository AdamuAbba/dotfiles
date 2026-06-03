#!/usr/bin/env sh
set -u

# print error, wait for keypress, then exit
die() {
	printf '%s\n' "$1" >&2
	printf '\nPress Enter to close...'
	read -r _
	exit "${2:-1}"
}

# re-exec inside a tmux popup if not already in one
if [ -z "${RUN_PROMPT_POPUP:-}" ] && [ -n "${TMUX:-}" ]; then
	exec tmux display-popup -E -w 65% -h 75% -T ' Run Prompt ' \
		-d "#{pane_current_path}" \
		env RUN_PROMPT_POPUP=1 "$0" "$@"
fi

PRESDIR="${XDG_CONFIG_HOME:-$HOME/.config}/scripts/ai/presets"
[ -d "$PRESDIR" ] || die "presets not found: $PRESDIR"

CHOICE="$(
	find "$PRESDIR" -maxdepth 1 -type f -exec basename {} \; | fzf \
		--border-label ' Prompt Picker ' \
		--prompt '   ' \
		--input-border \
		--header-border
)" || exit 0
[ -n "$CHOICE" ] || exit 0
PROMPT="$(cat "$PRESDIR/$CHOICE")"

if ! command -v opencode >/dev/null 2>&1; then
	die 'opencode: not found' 2
fi

OUT="$(mktemp)" || exit 1
TMPMSG=""
trap 'rm -f "$OUT" "$TMPMSG"' EXIT INT TERM

# Spinner shows animation while a background pid runs
# Usage: spin "message" pid
spin() {
	msg="$1"
	pid="$2"
	i=0
	while kill -0 "$pid" 2>/dev/null; do
		case $((i % 4)) in
		0) c='⠋' ;;
		1) c='⠙' ;;
		2) c='⠹' ;;
		3) c='⠸' ;;
		esac
		printf '\r  %s %s' "$c" "$msg"
		i=$((i + 1))
		sleep 0.1
	done
	wait "$pid" 2>/dev/null
	rc=$?
	printf '\r%*s\r' 40 ''
	return $rc
}

# run opencode in background; use json format so we can extract clean text
command opencode run --format json --model github-copilot/gpt-5-mini "$PROMPT" |
	jq -rj 'select(.type == "text") | .part.text' >"$OUT" &
spin "generating..." $!

# strip extension and check
BASE="$(basename "$CHOICE")"
NAME="${BASE%%.*}"
if [ "$NAME" != "COMMIT-MESSAGE" ]; then
	exit 0
fi

# extract inner commit message from fenced ```gitcommit block
COMMIT_MSG="$(awk '/```gitcommit/ {p=1; next} p && /```/ {exit} p {sub(/^[[:space:]]+/, ""); print}' <"$OUT")"

if [ -z "$COMMIT_MSG" ]; then
	printf 'no commit message found; raw output:\n\n' >&2
	sed -n '1,200p' "$OUT" >&2
	die '' 3
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
	NVIM_VIEWER=1 git commit --edit --signoff -F "$TMPMSG"
	;;
*)
	printf 'Cancelled.\n'
	exit 0
	;;
esac
