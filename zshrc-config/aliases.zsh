#============================================= ios specifics =============================================
alias ios-clean-simulator="rm -R ~/Library/Developer/CoreSimulator/Caches"
alias check-running-sim="xcrun simctl list devices | grep -B 1 Booted"
alias hide-menu-bar='osascript -e "tell application \"System Events\" to set autohide menu bar of dock preferences to true"'
alias show-menu-bar='osascript -e "tell application \"System Events\" to set autohide menu bar of dock preferences to false"'
alias finder-show-hidden="defaults write com.apple.finder AppleShowAllFiles true && killall Finder"
alias finder-hide-hidden="defaults write com.apple.finder AppleShowAllFiles false && killall Finder"

alias ls="eza --grid --no-quotes --color=always --long --sort=type --all --git --icons=always --no-filesize --no-time --no-user --no-permissions"
alias gg="lazygit"
alias rm='trash'
alias koji="koji --config=$HOME/.config/koji/config.toml"
alias ping="gping"
alias gsout="gnome-session-quit --logout --no-prompt"
alias edit-grub="nvim /etc/default/grub"
alias feh-view="feh --scale-down --image-bg '#282A36' --hide-pointer"
alias cpu-get-available="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors "
alias cpu-show-current="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
alias cpu-set-high="echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias update-node="nvm install --reinstall-packages-from=default --latest-npm 'lts/*'"
alias update-npm="npm install -g npm@latest"
alias update-brew-pkgs="brew update && brew upgrade && brew cleanup --prune=all"
alias agg="agg -v --theme dracula --font-size 23 --font-family '$THEME_FONT' --fps-cap 60"
alias presenterm="$HOME/Documents/presenterm/target/release/presenterm"
alias gh-mp="gh markdown-preview --dark-mode"
alias fastfetch='clear && echo -e "\n\n\n" && fastfetch && echo "\n\n\n"'
alias crates-tui="crates-tui --config-file $HOME/.config/crates-tui/config.toml --color-file $HOME/.config/crates-tui/dracula.yaml --frame-rate 60"
alias cs='env CARGO_SELECTOR_CONFIG=$HOME/.config/cargo-selector/config.toml cargo selector'

alias edit-bitcoin="nvim $HOME/Library/Application\ Support/Bitcoin/bitcoin.conf"
alias bitcoin-cli="$HOME/Documents/bitcoin/build/bin/bitcoin-cli"
alias bitcoind="$HOME/Documents/bitcoin/build/bin/bitcoind"
alias jqp="jqp --config $HOME/.config/jqp/config.yaml"
alias edit-pt="nvim $HOME/.config/presenterm/config.yaml"
alias edit-ncspot="nvim $HOME/.config/ncspot/config.toml"
alias edit-git-global="nvim $HOME/.config/git/config"
alias edit-git='nvim "$(git rev-parse --show-toplevel)/.git/config"'
alias edit-gg="nvim $HOME/.config/lazygit/config.yml"
alias edit-nvim="nvim $HOME/.config/nvim/"
alias edit-kba="nvim $HOME/.config/karabiner/assets/complex_modifications/"
alias edit-yz="nvim $HOME/.config/yazi/yazi.toml"
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
alias edit-skhd="nvim $HOME/.config/skhd/skhdrc"
alias edit-aero="nvim $HOME/.config/aerospace/aerospace.toml"

#============================================= lnd =============================================
alias edit-lnd="nvim ~/Library/Application\ Support/Lnd/lnd.conf"
#============================================= zsh =============================================
alias edit-zsh="nvim $HOME/.zshrc"
alias reload-zsh="source ~/.zshrc"
