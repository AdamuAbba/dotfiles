#!/usr/bin/env sh

SESSION="floating-term"

if ! /opt/homebrew/bin/zellij list-sessions | grep -q "$SESSION"; then
  /opt/homebrew/bin/wezterm cli spawn \
    --new-window \
    -- /opt/homebrew/bin/zellij \
    --session=floating-term \
    --new-session-with-layout=floating
else
  /opt/homebrew/bin/wezterm cli spawn \
    --new-window \
    -- /opt/homebrew/bin/zellij \
    attach "$SESSION"
fi
