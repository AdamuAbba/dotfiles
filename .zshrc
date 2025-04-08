#--------------------------------- Abba ------------------------------------------------
#--------------------------------- PLEASE ------------------------------------------------
#--------------------------------- Do ------------------------------------------------
#--------------------------------- NOT ------------------------------------------------
#--------------------------------- RE-ORDER ANYTHING ------------------------------------------------

#=============================================== List of all plugins ==============================
source $HOME/zshrc-config/plugins.zsh
#=============================================== zsh-vi-mode==============================
source $HOME/zshrc-config/zsh-vi-mode.zsh
#============================================== General zsh config ================================
source $HOME/zshrc-config/general_zsh_config.zsh
#============================================== text-editor =======================================
source $HOME/zshrc-config/text-editor.zsh
#-------------------------------------------- machine-specifics -----------------------
source $HOME/zshrc-config/machine_specifics.zsh
#-------------------------------------------- bat --------------------------------------------
source $HOME/zshrc-config/bat.zsh
#============================================ man ==================================================
source $HOME/zshrc-config/man.zsh
#============================================ bitcoin ==============================================
source $HOME/zshrc-config/bitcoin.zsh
#============================================ Yazi =================================================
source $HOME/zshrc-config/yazi.zsh
#============================================ homebrew ==============================================
source $HOME/zshrc-config/homebrew.zsh
#============================================ Television ============================================
source $HOME/zshrc-config/tv.zsh
#============================================ zellij ================================================
source $HOME/zshrc-config/zellij.zsh
#============================================== fzf =================================================
source $HOME/zshrc-config/fzf.zsh
#============================================ Github ================================================
source $HOME/zshrc-config/git.zsh
#============================================ Github ================================================
source $HOME/zshrc-config/atac.zsh
#============================================ nvm ===================================================
# ---- leave above OMZ initialization because of {nvm} ------------------------
source $HOME/zshrc-config/languages/javascript.zsh
#============================================ oh-my-zsh =============================================
source $HOME/zshrc-config/omz-config.zsh
#============================================ Aliases ===============================================
source $HOME/zshrc-config/aliases.zsh
#============================================ Additional completions for zsh ========================
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
#============================================ Lang (Do not remove from bottom) ======================
source $HOME/zshrc-config/languages/python.zsh
source $HOME/zshrc-config/languages/rust.zsh
source $HOME/zshrc-config/languages/ruby.zsh
source $HOME/zshrc-config/languages/go.zsh

bindkey -r "^R"

zle -N tv_zsh_history_widget
tv_zsh_history_widget() {
    # Capture the selection from 'tv zsh-history'
    local selected_command
    selected_command=$(tv zsh-history)  # Use `$(...)` to capture the output

    # If something was selected, put it on the command line
    if [[ -n $selected_command ]]; then
        LBUFFER+="$selected_command"
    fi
}

# Bind it to Ctrl+R
bindkey "^R" tv_zsh_history_widget

#============================================ keep at bottom (DO NOT TOUCH ABBA) ====================
source $ZSH/oh-my-zsh.sh
