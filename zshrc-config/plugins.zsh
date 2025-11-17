#============================================= plugin dependencies  ===========================
#============================================= configure early ================================

# --- ruby (rvm) ---
source $HOME/zshrc-config/languages/ruby.zsh
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
  rvm
  ruby
  ssh
  direnv
  gradle
  bundler
)
