ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_AUTOQUIT=true
ZSH_TMUX_DEFAULT_SESSION_NAME="default"
ZSH_TMUX_DETACHED=false

if [ -n "$TMUX" ] && [ "$(tmux display-message -p '#{session_name}' 2>/dev/null)" = "scratch" ]; then
  alias exit='tmux detach-client'
fi
