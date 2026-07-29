CONFIG_DIR="$HOME/.config"
SCRIPT_DIR="$CONFIG_DIR/scripts"

#============================================= ios =============================================
alias sim-clean="rm -r $HOME/Library/Developer/CoreSimulator/Caches"
alias xcode-clean="rm -rf $HOME/Library/Developer/Xcode/DerivedData/* && rm -rf $HOME/Library/Caches/org.swift.swiftpm"
alias check-running-sim="xcrun simctl list devices | grep -B 1 Booted"
alias hide-menu-bar='osascript -e "tell application \"System Events\" to set autohide menu bar of dock preferences to true"'
alias show-menu-bar='osascript -e "tell application \"System Events\" to set autohide menu bar of dock preferences to false"'

#TODO: make into scripts and exec with hammerspoon=>MenuHammer toggle menu
alias finder-show-hidden="defaults write com.apple.finder AppleShowAllFiles true && killall Finder"
alias finder-hide-hidden="defaults write com.apple.finder AppleShowAllFiles false && killall Finder"

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
alias edit-git-local='nvim "$(git rev-parse --show-toplevel)/.git/config"'
alias gbd="$SCRIPT_DIR/git/delete-branch.sh"
alias grpr="$SCRIPT_DIR/git/pr-review.sh $1"
alias ga="$SCRIPT_DIR/git/git-add-confirm.sh"

#============================================= POSIX/Unix util (enhancements) ========================================
alias ls="ls -p -a --color=always"

#============================================= tools =============================================
alias rm='trash'
alias update-brew-pkgs="brew update && brew upgrade -y && brew cleanup --prune=all"
alias agg="agg -v --theme dracula --font-size 23 --font-family '$THEME_FONT' --fps-cap 60"
alias jqp="jqp --config $HOME/.config/jqp/config.yaml"

#============================================= zsh =============================================
alias reload-zsh="omz reload"
