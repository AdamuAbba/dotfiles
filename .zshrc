#============================================ SHYTYPES ============================================
#============================================ YOU BASTARD =========================================
#============================================ DO ==================================================
#============================================ NOT =================================================
#============================================ FUCKING =============================================
#============================================ RE-ORDER ANYTHING ===================================

#============================================ Dracula theme========================================
#-------- Load dracula color palette before sourcing brew
source $HOME/zshrc-config/theme.zsh
#============================================ ai-models ============================================
source $HOME/zshrc-config/ai-models.zsh
#============================================ homebrew ============================================
source $HOME/zshrc-config/homebrew.zsh
#============================================ List of all plugins =================================
source $HOME/zshrc-config/plugins.zsh
#============================================ General zsh config ==================================
source $HOME/zshrc-config/general_zsh_config.zsh
#============================================ text-editor =========================================
source $HOME/zshrc-config/text-editor.zsh
#============================================ asciinema ===========================================
source $HOME/zshrc-config/asciinema.zsh
#============================================ machine-specifics ===================================
source $HOME/zshrc-config/machine_specifics.zsh
#============================================ bat =================================================
source $HOME/zshrc-config/bat.zsh
#============================================ man =================================================
source $HOME/zshrc-config/man.zsh
#============================================ bitcoin =============================================
source $HOME/zshrc-config/bitcoin.zsh
#============================================ docker ==============================================
source $HOME/zshrc-config/docker.zsh
#============================================ bitwarden ===========================================
source $HOME/zshrc-config/bitwarden.zsh
#============================================ Yazi ================================================
source $HOME/zshrc-config/yazi.zsh
#============================================ zellij ==============================================
source $HOME/zshrc-config/zellij.zsh
#============================================ fzf =================================================
source $HOME/zshrc-config/fzf.zsh
#============================================= ssh ================================================
source $HOME/zshrc-config/ssh.zsh
#============================================ Github ==============================================
source $HOME/zshrc-config/git.zsh
#============================================ atac ==============================================
# source $HOME/zshrc-config/atac.zsh
#============================================ Sketchy-bar =========================================
source $HOME/zshrc-config/sketchy-bar.zsh
#============================================ nvm =================================================
# ---- leave above OMZ initialization because of {nvm} ------------------------
source $HOME/zshrc-config/languages/javascript.zsh
#============================================ oh-my-zsh ===========================================
source $HOME/zshrc-config/omz-config.zsh
#============================================ Aliases =============================================
source $HOME/zshrc-config/aliases.zsh
#============================================ Additional completions for zsh ======================
source $HOME/zshrc-config/zsh-completions.zsh
#============================================ Lang (Do not remove from bottom) ====================
source $HOME/zshrc-config/languages/python.zsh
source $HOME/zshrc-config/languages/rust.zsh

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin"
export rvm_path="$HOME/.rvm"
[[ -s "$rvm_path/scripts/rvm" ]] && source "$rvm_path/scripts/rvm"
#============================================ keep at bottom (DO NOT TOUCH SHYTYPES) ==============
source $ZSH/oh-my-zsh.sh

#============================================ atuin =================================================
source $HOME/zshrc-config/atuin.zsh
