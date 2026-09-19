#!/bin/bash
# Browse Claude Code session transcripts in fzf and delete the ones you select.
#
# Sessions live as one JSONL transcript per conversation under
# ~/.claude/projects/<slugified-cwd>/<session-uuid>.jsonl. There is no built-in
# command to remove them, so this lists them the way `claude --resume` does and
# deletes whatever you pick.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../utils/helpers.sh"

DRACULA_GREEN="#404F3C"
DRACULA_WHITE="#ffffff"

PROJECTS_DIR="${CLAUDE_PROJECTS_DIR:-$HOME/.claude/projects}"
CURRENT_ID="${CLAUDE_CODE_SESSION_ID:-}"
DRY_RUN=0

# Terminal width, read from the controlling tty so it stays correct even when
# the script's own stdout is captured in a command substitution. Falls back to a
# conservative 100 columns when there is no tty (piped, cron, CI).
term_width() {
    local w=""
    w="$( { stty size </dev/tty; } 2>/dev/null | cut -d' ' -f2 )" || w=""
    [ -n "$w" ] || w="$(tput cols 2>/dev/null)" || w=""
    case "$w" in
        '' | *[!0-9]*) w=100 ;;
    esac
    printf '%s' "$w"
}

# Claude records the session title, message count and git branch as it goes, so
# the newest values sit at the end of the transcript. Reading the last 50 lines
# is enough and avoids scanning files that run to several megabytes.
session_meta() {
    tail -n 50 "$1" 2>/dev/null | jq -rs '
        def clean: if . == null then "" else tostring | gsub("[\n\t]"; " ") end;
        ([.[] | .aiTitle // empty] | last | clean),
        (([.[] | .gitBranch // empty] | last | clean) | if . == "" then "-" else . end)
    ' 2>/dev/null || printf '\n-\n'
}

# Sessions too short to have earned a title fall back to their opening prompt.
first_prompt() {
    head -n 300 "$1" 2>/dev/null | jq -rs '
        def text: if type == "string" then .
                  else [.[]? | select(.type == "text") | .text] | join(" ") end;
        [ .[]
          | select(.type == "user" and (.isMeta // false) == false)
          | select((.message.content | text | ltrimstr(" ")) | startswith("<") | not)
        ] | (.[0].message.content | text) // ""
    ' 2>/dev/null || printf ''
}

# The working directory is read from the JSON rather than decoded from the
# directory name, because the slug replaces "/" with "-" and that is ambiguous
# for paths that already contain hyphens.
session_cwd() {
    head -n 300 "$1" 2>/dev/null | jq -rs '[.[] | .cwd // empty] | first // "?"' 2>/dev/null || printf '?'
}

# One row per session, newest first: display columns followed by the transcript
# path as a hidden trailing field for fzf to hand back.
build_index() {
    find "$PROJECTS_DIR" -type f -name '*.jsonl' -print0 |
        while IFS= read -r -d '' file; do
            local id mtime title branch proj
            id="$(basename "$file" .jsonl)"
            [ "$id" = "$CURRENT_ID" ] && continue
            { read -r title; read -r branch; } < <(session_meta "$file")
            [ -n "$title" ] || title="$(first_prompt "$file")"
            [ -n "$title" ] || title="(untitled)"
            title="$(printf '%s' "$title" | tr '\n\t' '  ' | cut -c1-"$TITLE_WIDTH")"
            proj="$(basename "$(session_cwd "$file")")"
            mtime="$(stat -f '%m' "$file")"
            printf '%s\t%s\t%-20s %-22s %s\t%s\n' \
                "$proj" \
                "$mtime" \
                "$(printf '%s' "$proj" | cut -c1-20)" \
                "$(printf '%s' "$branch" | cut -c1-22)" \
                "$title" \
                "$file"
        done | sort -t$'\t' -k1,1 -k2,2nr | cut -f3-
}

select_sessions() {
    printf '%s\n' "$1" |
        fzf --multi \
            --delimiter=$'\t' --with-nth=1 \
            --info=hidden \
            --no-separator \
            --prompt='' \
            --pointer='>' \
            --color=bg+:"$DRACULA_GREEN",fg+:"$DRACULA_WHITE" \
            --color=label:bold:"$DRACULA_WHITE" |
        cut -f2
}

remove_sessions() {
    if command -v trash >/dev/null 2>&1; then
        trash "$@"
        success "Moved $# session(s) to Trash"
    else
        rm -- "$@"
        success "Deleted $# session(s)"
    fi
}

main() {
    local tool index line reply
    local picked=()

    # Fixed columns consume 44 chars (project + branch); fzf's pointer and
    # multi-select gutter take a few more. Reserve 50, rest goes to the title.
    TITLE_WIDTH=$(($(term_width) - 50))
    [ "$TITLE_WIDTH" -ge 24 ] || TITLE_WIDTH=24

    if [ "${1:-}" = "--dry-run" ] || [ "${1:-}" = "-n" ]; then
        DRY_RUN=1
    fi

    for tool in fzf jq; do
        command -v "$tool" >/dev/null 2>&1 || {
            error "'$tool' is required but not installed"
            exit 1
        }
    done

    if [ ! -d "$PROJECTS_DIR" ]; then
        error "No sessions directory at $PROJECTS_DIR"
        exit 1
    fi

    index="$(build_index)"
    if [ -z "$index" ]; then
        warning "No sessions found under $PROJECTS_DIR"
        exit 0
    fi

    while IFS= read -r line; do
        picked+=("$line")
    done < <(select_sessions "$index")

    if [ "${#picked[@]}" -eq 0 ]; then
        info "Nothing selected"
        exit 0
    fi

    info "About to delete ${#picked[@]} session(s):"
    printf '    %s\n' "${picked[@]}"

    if [ "$DRY_RUN" -eq 1 ]; then
        info "Dry run - nothing removed"
        exit 0
    fi

    read -r -p "Delete these? [y/N] " reply
    case "$reply" in
        [yY]) remove_sessions "${picked[@]}" ;;
        *) info "Aborted" ;;
    esac
}

main "$@"
