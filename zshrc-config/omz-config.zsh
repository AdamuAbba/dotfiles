export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

#============================================= Base configs =====================================
zstyle ':omz:lib:directories' aliases no
zstyle ':omz:lib:*' aliases no
#============================================= zoxide ===========================================
export ZOXIDE_CMD_OVERRIDE="cd"
#============================================= VI-mode ==========================================
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
INSERT_MODE_INDICATOR="%F{yellow}+%f"
bindkey -M viins 'jj' vi-cmd-mode
PROMPT="$PROMPT\$(vi_mode_prompt_info)"
RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"

#============================================= fzf-tab ==========================================
zstyle ':fzf-tab:*' continuous-trigger '/'
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:(cd|eza|bat):*' fzf-preview 'eza -1 --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions $realpath'
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-min-height 15
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-pad 4

#============================================= Text object stuff ================================
# Text object for matching characters between a particular delimiter
#
# Quoted
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# Bracketed

local group=(
  # arround
  "a("
  "a)"
  "a["
  "a]"
  "a{"
  "a}"
  "a<"
  "a>"
  # inside
  "i("
  "i)"
  "i["
  "i]"
  "i{"
  "i}"
  "i<"
  "i>"
)
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in "${group[@]}"; do
    bindkey -M $m $c select-bracketed
  done
done
