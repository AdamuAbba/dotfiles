CONFIG_DIR="$HOME/.config"
SCRIPT_DIR="$CONFIG_DIR/scripts"
BITCOIN_DIR="$HOME/Library/Application\ Support/Bitcoin/"

#============================================= ios =============================================
alias sim-clean="rm -r $HOME/Library/Developer/CoreSimulator/Caches"
alias xcode-clean="rm -r $HOME/Library/Developer/Xcode/DerivedData"
alias check-running-sim="xcrun simctl list devices | grep -B 1 Booted"
alias hide-menu-bar='osascript -e "tell application \"System Events\" to set autohide menu bar of dock preferences to true"'
alias show-menu-bar='osascript -e "tell application \"System Events\" to set autohide menu bar of dock preferences to false"'

#TODO: make into scripts and exec with hammerspoon=>MenuHammer toggle menu
alias finder-show-hidden="defaults write com.apple.finder AppleShowAllFiles true && killall Finder"
alias finder-hide-hidden="defaults write com.apple.finder AppleShowAllFiles false && killall Finder"

#============================================= linux =============================================
alias gsout="gnome-session-quit --logout --no-prompt"
alias edit-grub="nvim /etc/default/grub"
alias feh-view="feh --scale-down --image-bg '#282A36' --hide-pointer"
alias cpu-get-available="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors "
alias cpu-show-current="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
alias cpu-set-high="echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"

#============================================= docker =============================================
alias edit-services="nvim $DEV_SERVICES"
alias colima-start="colima start --arch aarch64 --vm-type=vz --vz-rosetta --cpu 4 --memory 4 --disk 64"
alias oxker="oxker --host $DOCKER_HOST --config-file $HOME/.config/oxker/config.toml"

#============================================= bitcoin =============================================
alias rpcauth="python3 $HOME/Documents/bitcoin/share/rpcauth/rpcauth.py"
alias edit-bitcoin="nvim $HOME/Library/Application\ Support/Bitcoin/bitcoin.conf"
alias edit-litd="nvim $HOME/Library/Application\ Support/lit/lit.conf"
alias bitcoin-cli="$HOME/Documents/bitcoin/build/bin/bitcoin-cli -conf=$HOME/Library/Application\ Support/Bitcoin/bitcoin.conf"
alias bitcoind="$HOME/Documents/bitcoin/build/bin/bitcoind -conf=$HOME/Library/Application\ Support/Bitcoin/bitcoin.conf"

#============================================= lnd =============================================
alias edit-lnd="nvim ~/Library/Application\ Support/Lnd/lnd.conf"
alias lnd="lnd --configfile=$HOME/Library/Application\ Support/Lnd/lnd.conf"

#============================================= AI =============================================
alias run-prompt="$HOME/.config/scripts/ai/run-prompt.sh"

#============================================= github =============================================
alias edit-git-global="nvim $HOME/.config/git/config"
alias edit-git='nvim "$(git rev-parse --show-toplevel)/.git/config"'
alias gbd="$SCRIPT_DIR/git/delete-branch.sh"
alias ga="$SCRIPT_DIR/git/git-add-confirm.sh"

#============================================= POSIX/Unix util (enhancements) ========================================
alias -g -- cat="$SCRIPT_DIR/mac-os/view.sh"
alias man="$SCRIPT_DIR/mac-os/manpopup.sh"
alias ls="eza --group-directories-first --grid --no-quotes --color=always --sort=type --all --icons=always --no-filesize --no-time --no-user --no-permissions --show-symlinks"

#============================================= tools =============================================
alias kpp="gruyere --details"
alias fm="fzf-make"
alias rm='trash'
alias koji="koji --config=$HOME/.config/koji/config.toml"
alias update-node="nvm install --reinstall-packages-from=default --latest-npm 'lts/*'"
alias update-npm="npm install -g npm@latest"
alias update-brew-pkgs="brew update && brew upgrade && brew cleanup --prune=all"
alias agg="agg -v --theme dracula --font-size 23 --font-family '$THEME_FONT' --fps-cap 60"
alias presenterm="$HOME/Documents/presenterm/target/release/presenterm"
alias ghmp="gh markdown-preview --dark-mode"
alias fastfetch='clear && echo -e "\n\n\n" && fastfetch && echo "\n\n\n"'
alias speedtest="speedtest -u decimal-bytes"
alias jqp="jqp --config $HOME/.config/jqp/config.yaml"
alias edit-dotfiles="cd $HOME/Documents/dotfiles && nvim -c 'lua require(\"snacks\").picker(\"files\", { root = false, hidden = true, ignored = true })'"
alias edit-z-layout="nvim $HOME/.config/zellij/layouts/default.kdl"
alias edit-vault="nvim $HOME/Documents/shytypes-obs-vault/"
alias mini-trash="cd ~/.local/share/nvim/mini.files/trash/ && ls"

#============================================= zsh =============================================
alias reload-zsh="omz reload"
