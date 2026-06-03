#!/bin/sh
#
# pr-review.sh - Open a PR review session with codediff + opencode
#
# Usage: pr-review.sh <pr-number>
# Example: pr-review.sh 123

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=../utils/helpers.sh
. "$SCRIPT_DIR/../utils/helpers.sh"

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    error "$1 is required but not found in PATH"
    exit 1
  }
}

validate_args() {
  if [ $# -eq 0 ] || [ -z "${1:-}" ]; then
    error "Usage: pr-review.sh <pr-number>"
    exit 1
  fi

  case "$1" in
  *[!0-9]*)
    error "PR number must be a positive integer, got: $1"
    exit 1
    ;;
  esac
}

validate_environment() {
  require_command opencode
  require_command nvim
  require_command tmux
  require_command git
  require_command gh

  if [ -z "${TMUX:-}" ]; then
    error "Must be run inside a tmux session"
    exit 1
  fi

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    error "Must be run inside a git repository"
    exit 1
  fi
}

detect_base_branch() {
  if git show-ref --verify --quiet refs/heads/main 2>/dev/null; then
    printf "main"
  elif git show-ref --verify --quiet refs/heads/master 2>/dev/null; then
    printf "master"
  else
    error "Could not detect base branch (neither main nor master found)"
    exit 1
  fi
}

detect_pr_remote() {
  if git remote get-url upstream >/dev/null 2>&1; then
    printf "upstream"
  elif git remote get-url origin >/dev/null 2>&1; then
    printf "origin"
  else
    error "No git remote configured (expected 'upstream' or 'origin')"
    exit 1
  fi
}

fetch_pr() {
  pr_number="$1"
  remote=""

  remote="$(detect_pr_remote)"

  info "Fetching PR #${pr_number} from ${remote}..."
  git fetch "$remote" "pull/${pr_number}/head:pr-${pr_number}" 2>/dev/null
}

switch_to_pr() {
  pr_number="$1"
  branch_name=""

  info "Resolving PR #${pr_number}..."
  branch_name="pr-${pr_number}"

  fetch_pr "$pr_number"

  git checkout "$branch_name" 2>/dev/null || {
    error "Failed to checkout PR branch: $branch_name"
    exit 1
  }
  success "Switched to PR #${pr_number} branch"
}

get_worktree_path() {
  git rev-parse --show-toplevel 2>/dev/null
}

open_diff_window() {
  pr_number="$1"
  base_branch="$2"
  window_name="PR-${pr_number}"

  info "Opening codediff window: ${window_name}"
  tmux new-window -n " PR Diff" "nvim -c 'CodeDiff ${base_branch}...'"
}

open_review_window() {
  pr_number="$1"
  base_branch="$2"
  window_name="PR-${pr_number}-review"

  info "Opening opencode review window: ${window_name}"
  tmux new-window -n "󱙺  Opencode" \
    "opencode --model github-copilot/claude-opus-4.6 --prompt '@oracle: review the PR changes for pr-${pr_number} branch against ${base_branch} and include important code snippets where relevant.'"
}

main() {
  validate_args "$@"
  validate_environment

  pr_number="$1"
  base_branch="$(detect_pr_remote)/$(detect_base_branch)"

  switch_to_pr "$pr_number"

  # Command window
  tmux new-window -n "  Commands" "success \"PR #${pr_number} review session ready\""

  # NVIM CodeDiff  window
  open_diff_window "$pr_number" "$base_branch"

  # AI review window
  open_review_window "$pr_number" "$base_branch"

}

main "$@"
