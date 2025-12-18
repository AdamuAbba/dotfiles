#!/usr/bin/env sh

tmux send-keys "nvim +'lua Snacks.picker(\"files\", { root = false, layout = \"select_with_preview\" })'" Enter
