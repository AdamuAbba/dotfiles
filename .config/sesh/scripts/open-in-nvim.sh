#!/usr/bin/env sh

tmux send-keys "nvim -c 'lua require(\"snacks\").picker(\"files\", { root = false, layout = \"select_with_preview\" })'" Enter
