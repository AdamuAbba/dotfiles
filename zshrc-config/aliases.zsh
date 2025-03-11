#============================================= Aliases =============================================
alias ios-clean-simulator="rm -R ~/Library/Developer/CoreSimulator/Caches"
alias cd="z"
alias ping="gping"
alias ls="eza --grid --no-quotes --color=always --long --sort=type --all --git --icons=always --no-filesize --no-time --no-user --no-permissions"
alias gg="lazygit"
alias gsout="gnome-session-quit --logout --no-prompt"
alias edit-grub="nvim /etc/default/grub"
alias feh-view="feh --scale-down --image-bg '#282A36' --hide-pointer"
alias cpu-get-available="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors "
alias cpu-show-current="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
alias cpu-set-high="echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias update-node="nvm install --reinstall-packages-from=default --latest-npm 'lts/*'"

alias edit-bitcoin="nvim ~/Library/Application Support/Bitcoin/bitcoin.conf"
alias edit-nvim="nvim ~/dotfiles/.config/nvim/"
alias edit-alias="nvim ~/dotfiles/zshrc-config/aliases.zsh"
alias edit-starship="nvim ~/dotfiles/.config/starship.toml"
alias edit-wezterm="nvim ~/dotfiles/.config/wezterm/"
alias edit-hx="hx ~/dotfiles/.config/helix/config.toml"
alias edit-hx-lang="hx ~/dotfiles/.config/helix/languages.toml"
alias edit-zellij="nvim $HOME/dotfiles/.config/zellij/config.kdl"
alias edit-tv="nvim $HOME/dotfiles/.config/television/config.toml"

#============================================= lnd =============================================
alias edit-lnd="nvim ~/Library/Application\ Support/Lnd/lnd.conf"
#============================================= zsh =============================================
alias edit-zsh="nvim ~/dotfiles/.zshrc"
alias reload-zsh="source ~/.zshrc"
