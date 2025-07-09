export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
#============================================= zsh-fzf-history-search ===========================
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
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
