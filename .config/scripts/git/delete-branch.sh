#!/usr/bin/env sh

set -eu

main() {
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

  selected=$(printf '%s\n' "$branches" | fzf --height=100% --prompt=' ') || exit 0

  [ -z "$selected" ] && exit 0
  branch=$selected

  if git remote get-url origin >/dev/null 2>&1; then
    remote_name=origin
  else
    remote_name=$(git remote 2>/dev/null | sed -n '1p' || true)
  fi

  remote_deleted=1
  push_status=1
  if [ -n "$remote_name" ]; then
    if git push "$remote_name" --delete "$branch" >/dev/null 2>&1; then
      push_status=0
    elif git push "$remote_name" :"$branch" >/dev/null 2>&1; then
      push_status=0
    else
      push_status=1
    fi

    if [ $push_status -eq 0 ]; then
      remote_deleted=0
      printf 'remote:%s/%s deleted\n' "$remote_name" "$branch"
    else
      printf 'remote deletion failed for %s/%s\n' "$remote_name" "$branch" >&2
    fi
  else
    printf 'no remote configured; skipped remote deletion\n'
  fi

  local_deleted=1
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
        git checkout "$fallback" >/dev/null 2>&1 || true
      else
        printf 'cannot switch away from branch "%s" (no other branch); skipping local delete\n' "$branch" >&2
        exit 0
      fi
    fi

    if git branch -D "$branch" >/dev/null 2>&1; then
      local_deleted=0
      printf 'local:%s deleted\n' "$branch"
    else
      printf 'failed to delete local:%s\n' "$branch" >&2
    fi
  else
    printf 'local branch not found: %s\n' "$branch"
  fi

  if [ "${remote_deleted:-1}" -eq 0 ] && [ "${local_deleted:-1}" -eq 0 ]; then
    if [ -n "$remote_name" ]; then
      printf ' Success: branch %s deleted locally and on %s\n' "$branch" "$remote_name"
    else
      printf ' Success: branch %s deleted locally\n' "$branch"
    fi
  elif [ "${remote_deleted:-1}" -eq 0 ]; then
    printf 'Partial success: remote %s/%s deleted; local deletion failed or skipped\n' "$remote_name" "$branch"
  elif [ "${local_deleted:-1}" -eq 0 ]; then
    if [ -n "$remote_name" ]; then
      printf 'Partial success: local %s deleted; remote deletion failed or skipped\n' "$branch"
    else
      printf '  Success: local %s deleted (no remote configured)\n' "$branch"
    fi
  fi

  printf '\nPress Enter to close...'
  IFS= read -r _ || true
}

main "$@"

exit 0
