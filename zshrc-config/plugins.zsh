#============================================= plugin dependencies  ===========================
#---- configure languages early because of plugins
source "$HOME/zshrc-config/languages/rust.zsh"
source "$HOME/zshrc-config/languages/python.zsh"
source "$HOME/zshrc-config/languages/ruby.zsh"
source "$HOME/zshrc-config/languages/go.zsh"
source "$HOME/zshrc-config/languages/javascript.zsh"

#============================================= plugins ===========================
plugins=(
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
  command-not-found
  colored-man-pages
  rust
  react-native
  safe-paste
  ssh
  direnv
  gradle
  bundler
)
