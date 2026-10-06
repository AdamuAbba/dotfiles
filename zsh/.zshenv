# Keep PATH and fpath free of duplicates. The config files prepend their entries
# unconditionally, so a shell started from another shell (every new tmux pane,
# `exec zsh`) would otherwise add them all a second time. With -U, zsh keeps only
# the first occurrence of each entry.
typeset -U PATH path FPATH fpath
