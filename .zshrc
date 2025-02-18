#--------------------------------- Abba ------------------------------------------------
#--------------------------------- PLEASE ------------------------------------------------
#--------------------------------- Do ------------------------------------------------
#--------------------------------- NOT ------------------------------------------------
#--------------------------------- RE-ORDER ------------------------------------------------

#=============================================== List of all plugins =================================
source ~/dotfiles/zshrc-config/plugins.zsh
#-------------------------------------------- General zsh config --------------------------------
source ~/dotfiles/zshrc-config/general_zsh_config.zsh
#============================================= fzf ================================================
source ~/dotfiles/zshrc-config/fzf.zsh
#--------------------------------------------- text-editor --------------------------------------
source ~/dotfiles/zshrc-config/text-editor.zsh
#-------------------------------------------- machine-specifics -----------------------
source ~/dotfiles/zshrc-config/machine_specifics.zsh
#-------------------------------------------- bat --------------------------------------------
source ~/dotfiles/zshrc-config/bat.zsh
#-------------------------------------------- bitcoin ------------------------------
source ~/dotfiles/zshrc-config/bitcoin.zsh
#-------------------------------------------- Yazi ------------------------------
source ~/dotfiles/zshrc-config/yazi.zsh
#============================================ homebrew ==============================================
source ~/dotfiles/zshrc-config/homebrew.zsh
#============================================ Github ================================================
source ~/dotfiles/zshrc-config/git.zsh
#============================================ nvm ===================================================
# ---- leave above OMZ initialization because of {nvm} ------------------------
source ~/dotfiles/zshrc-config/languages/javascript.zsh
#============================================ oh-my-zsh =============================================
source ~/dotfiles/zshrc-config/omz-config.zsh
#============================================ Aliases ===============================================
source ~/dotfiles/zshrc-config/aliases.zsh
#============================================ Windsurf ==============================================
export PATH="/Users/abba/.codeium/windsurf/bin:$PATH"
#============================================ Additional completions for zsh ========================
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
#============================================ keep at bottom (DO NOT TOUCH ABBA) ====================
source $ZSH/oh-my-zsh.sh
#============================================ Lang (Do not remove from bottom) ======================
source ~/dotfiles/zshrc-config/languages/python.zsh
source ~/dotfiles/zshrc-config/languages/rust.zsh
source ~/dotfiles/zshrc-config/languages/ruby.zsh
source ~/dotfiles/zshrc-config/languages/go.zsh
