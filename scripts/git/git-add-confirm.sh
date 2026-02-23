#!/bin/bash
#
# git-add-confirm.sh - Confirms tests and CI have been run before staging files
#
# Usage: ga [git add arguments...]
# Example: ga . | ga -p | ga file1.txt file2.txt

set -euo pipefail

# Handle Ctrl+C and other interrupts
trap 'echo -e "\n${RED}Cancelled: Staging aborted${NC}"; exit 130' INT TERM

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PROJECT_NAME=$(basename "$(pwd)")

to_lower() {
  echo "$1" | tr '[:upper:]' '[:lower:]'
}

confirm_prompt() {
  local question="$1"
  local completed="${2:-}"
  local answer
  local tmpfile

  if [[ -n "${TMUX:-}" ]]; then
    # Inside tmux: use display-popup for a nicer UX
    # Use a temp file to capture the answer since popup runs in isolated env
    tmpfile=$(mktemp)
    trap "rm -f '$tmpfile'" RETURN

    # Build the display content
    local display_content="Project: $PROJECT_NAME\n"
    if [[ -n "$completed" ]]; then
      display_content+="\n$completed\n"
    fi
    display_content+="\n$question (y/n): "

    # Calculate height based on content (base 5 + 2 lines per completed item)
    local height=7
    if [[ -n "$completed" ]]; then
      height=9
    fi

    tmux display-popup -E -T " Git Sanity Checks " -w 50 -h "$height" \
      "printf '$display_content' && read ans && echo \"\$ans\" > '$tmpfile'"

    if [[ -f "$tmpfile" && -s "$tmpfile" ]]; then
      answer=$(cat "$tmpfile")
      rm -f "$tmpfile"
    else
      rm -f "$tmpfile" 2>/dev/null
      echo -e "${RED}Cancelled: Staging aborted${NC}"
      exit 130
    fi
  else
    # Fallback: standard terminal prompt
    printf "%bProject: %s%b\n" "$GREEN" "$PROJECT_NAME" "$NC"
    if [[ -n "$completed" ]]; then
      printf "%b%s%b\n" "$GREEN" "$completed" "$NC"
    fi
    printf "%b%s (y/n): %b" "$YELLOW" "$question" "$NC"
    read -r answer
  fi

  answer=$(to_lower "$answer")
  [[ "$answer" == "y" || "$answer" == "yes" ]]
}

main() {
  if [[ $# -eq 0 ]]; then
    echo -e "${RED}Error: No files specified for staging${NC}"
    echo "Usage: ga [files...]"
    exit 1
  fi

  if ! confirm_prompt "Have you run tests?"; then
    echo -e "${RED}Aborted: Please run tests before staging changes${NC}"
    exit 1
  fi

  if ! confirm_prompt "Have you run CI locally (act)?" "[✓] Have you run tests?"; then
    echo -e "${RED}Aborted: Please run CI locally with 'act' before staging changes${NC}"
    exit 1
  fi

  local completed="[✓] Have you run tests?\n[✓] Have you run CI locally (act)?"

  if [[ -n "${TMUX:-}" ]]; then
    if ! tmux display-popup -E -T " Git Sanity Checks " -w 50 -h 10 \
      "printf 'Project: $PROJECT_NAME\n\n$completed\n\nPress Enter to stage files...' && read"; then
      echo -e "${RED}Cancelled: Staging aborted${NC}"
      exit 130
    fi
  else
    printf "%bProject: %s%b\n" "$GREEN" "$PROJECT_NAME" "$NC"
    printf "%b%b%b\n" "$GREEN" "$completed" "$NC"
    printf "%bPress Enter to stage files...%b" "$YELLOW" "$NC"
    read -r
  fi

  echo -e "${GREEN}Proceeding with git add...${NC}"
  git add "$@"
  echo -e "${GREEN}Files staged successfully${NC}"
}

main "$@"
