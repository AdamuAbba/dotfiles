#============================================= Aliases =============================================
alias ios-clean-simulator="rm -R ~/Library/Developer/CoreSimulator/Caches"
alias check-running-sim="xcrun simctl list devices | grep -B 1 Booted"

alias ping="gping"
alias ls="eza --grid --no-quotes --color=always --long --sort=type --all --git --icons=always --no-filesize --no-time --no-user --no-permissions"
alias gg="lazygit"
alias rm='trash'
alias ping="gping"
alias gsout="gnome-session-quit --logout --no-prompt"
alias edit-grub="nvim /etc/default/grub"
alias feh-view="feh --scale-down --image-bg '#282A36' --hide-pointer"
alias cpu-get-available="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors "
alias cpu-show-current="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
alias cpu-set-high="echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias update-node="nvm install --reinstall-packages-from=default --latest-npm 'lts/*'"
alias update-npm="npm install -g npm@latest"
alias update-brew-pkgs="brew update && brew upgrade && brew cleanup"

alias edit-bitcoin="nvim ~/Library/Application Support/Bitcoin/bitcoin.conf"
alias edit-nvim="nvim $HOME/.config/nvim/"
alias edit-alias="nvim $HOME/zshrc-config/aliases.zsh"
alias edit-starship="nvim $HOME/.config/starship.toml"
alias edit-wezterm="nvim $HOME/.config/wezterm/wezterm.lua"
alias edit-hx="hx $HOME/.config/helix/config.toml"
alias edit-hx-lang="hx $HOME/.config/helix/languages.toml"
alias edit-zellij="nvim $HOME/.config/zellij/config.kdl"
alias edit-tv="nvim $HOME/.config/television/config.toml"
alias edit-plugins="nvim $HOME/zshrc-config/plugins.zsh"
alias edit-z-layout="nvim $HOME/.config/zellij/layouts/default.kdl"
alias edit-atac-theme="nvim $ATAC_THEME"
alias edit-atac-kb="nvim $ATAC_KEY_BINDINGS"

#============================================= lnd =============================================
alias edit-lnd="nvim ~/Library/Application\ Support/Lnd/lnd.conf"
#============================================= zsh =============================================
alias edit-zsh="nvim $HOME/.zshrc"
alias reload-zsh="source ~/.zshrc"
