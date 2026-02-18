#!/usr/bin/env sh

set -eu

DRACULA_GREEN="#404F3C"
DRACULA_WHITE="#ffffff"

# Spinner runs command in background and shows animation
# Usage: spin "message" command [args...]
spin() {
  msg="$1"
  shift
  "$@" >/dev/null 2>&1 &
  pid=$!
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
  return $?
}

# Clear spinner line
clear_line() {
  printf '\r%*s\r' 60 ''
}

# Deletion flow (runs inside tmux popup)
delete_branch() {
  branch="$1"
  repo_root="$2"

  cd "$repo_root" || exit 1

  printf '\n'

  # Determine remote
  if git remote get-url origin >/dev/null 2>&1; then
    remote_name=origin
  else
    remote_name=$(git remote 2>/dev/null | sed -n '1p' || true)
  fi

  remote_deleted=1
  local_deleted=1

  # Delete remote branch
  if [ -n "$remote_name" ]; then
    if spin "Deleting remote $remote_name/$branch..." git push "$remote_name" --delete "$branch"; then
      remote_deleted=0
      clear_line
      printf '  ✓ Remote %s/%s deleted\n' "$remote_name" "$branch"
    elif spin "Retrying remote deletion..." git push "$remote_name" :"$branch"; then
      remote_deleted=0
      clear_line
      printf '  ✓ Remote %s/%s deleted\n' "$remote_name" "$branch"
    else
      clear_line
      printf '  ✗ Remote deletion failed for %s/%s\n' "$remote_name" "$branch"
    fi
  else
    printf '  - No remote configured; skipped remote deletion\n'
  fi

  # Delete local branch
  if git show-ref --verify --quiet "refs/heads/$branch" 2>/dev/null; then
    current=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)
    if [ "$current" = "$branch" ]; then
      if git show-ref --verify --quiet refs/heads/main 2>/dev/null; then
        fallback=main
      elif git show-ref --verify --quiet refs/heads/master 2>/dev/null; then
        fallback=master
      else
        fallback=$(git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null | awk -v b="$branch" '$0!=b{print; exit}' || true)
      fi

      if [ -n "$fallback" ]; then
        spin "Switching to $fallback..." git checkout "$fallback"
        clear_line
        printf '  ✓ Switched to %s\n' "$fallback"
      else
        printf '  ✗ Cannot switch away from branch "%s" (no other branch); skipping local delete\n' "$branch"
        printf '\nPress Enter to close...'
        IFS= read -r _ || true
        exit 0
      fi
    fi

    if spin "Deleting local branch $branch..." git branch -D "$branch"; then
      local_deleted=0
      clear_line
      printf '  ✓ Local %s deleted\n' "$branch"
    else
      clear_line
      printf '  ✗ Failed to delete local %s\n' "$branch"
    fi
  else
    printf '  - Local branch not found: %s\n' "$branch"
  fi

  # Summary
  printf '\n'
  if [ "${remote_deleted:-1}" -eq 0 ] && [ "${local_deleted:-1}" -eq 0 ]; then
    if [ -n "$remote_name" ]; then
      printf '  ✓ Success: branch %s deleted locally and on %s\n' "$branch" "$remote_name"
    else
      printf '  ✓ Success: branch %s deleted locally\n' "$branch"
    fi
  elif [ "${remote_deleted:-1}" -eq 0 ]; then
    printf '  ~ Partial: remote %s/%s deleted; local deletion failed or skipped\n' "$remote_name" "$branch"
  elif [ "${local_deleted:-1}" -eq 0 ]; then
    if [ -n "$remote_name" ]; then
      printf '  ~ Partial: local %s deleted; remote deletion failed or skipped\n' "$branch"
    else
      printf '  ✓ Success: local %s deleted (no remote configured)\n' "$branch"
    fi
  else
    printf '  ✗ Failed to delete branch %s\n' "$branch"
  fi

  printf '\nPress Enter to close...'
  IFS= read -r _ || true
}

main() {
  # Handle popup mode (called from tmux display-popup)
  if [ "${1:-}" = "--popup" ]; then
    shift
    branch="$1"
    repo_root="$2"
    delete_branch "$branch" "$repo_root"
    exit 0
  fi

  command -v git >/dev/null 2>&1 || {
    printf '%s\n' "git required" >&2
    exit 1
  }
  command -v fzf >/dev/null 2>&1 || {
    printf '%s\n' "fzf required" >&2
    exit 1
  }

  repo_root=$(git rev-parse --show-toplevel 2>/dev/null || true)
  if [ -z "$repo_root" ]; then
    printf '%s\n' "Not inside a git repository" >&2
    exit 1
  fi

  cd "$repo_root" || exit 1

  branches=$(git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null | sort)

  if [ -z "$branches" ]; then
    printf '%s\n' "No local branches found" >&2
    exit 0
  fi

  selected=$(printf '%s\n' "$branches" | fzf --tmux 50%,50% \
    --info=hidden \
    --padding=0,0,0,1.5% \
    --border=rounded \
    --border-label=" Delete git branch " \
    --color=label:bold:${DRACULA_WHITE} \
    --color=border:bold:${DRACULA_WHITE} \
    --color=input-border:${DRACULA_WHITE},input-label:${DRACULA_WHITE} \
    --color=bg+:${DRACULA_GREEN},fg+:${DRACULA_WHITE} \
    --border-label-pos=3 \
    --list-border=none \
    --input-border \
    --prompt=' ') || exit 0

  [ -z "$selected" ] && exit 0
  branch=$selected

  # Get script path for re-invocation
  script_path="$(cd "$(dirname "$0")" && pwd)/$(basename "$0")"

  # Check if we're in tmux
  if [ -n "${TMUX:-}" ]; then
    tmux display-popup \
      -w 60% \
      -h 40% \
      -T " Deleting: $branch " \
      -E "$script_path --popup '$branch' '$repo_root'"
  else
    # Not in tmux, run directly
    delete_branch "$branch" "$repo_root"
  fi
}

main "$@"

exit 0
