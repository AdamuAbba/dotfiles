#============================================= plugin dependencies  ===========================
#---- configure early because of plugins

# --- rust ---
source $HOME/zshrc-config/languages/rust.zsh
# --- js/ts ---
source $HOME/zshrc-config/languages/javascript.zsh

#============================================= plugins ===========================
plugins=(
  tmux
  zoxide
  pip
  golang
  gpg-agent
  gem
  pod
  docker
  starship
  docker-compose
  pyenv
  ubuntu
  gh
  vi-mode
  fzf-tab
  nvm
  command-not-found
  colored-man-pages
  rust
  react-native
  safe-paste
  nodenv
  ssh
  direnv
  gradle
  bundler
)
