export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"

update_rvm() {
  rvm get stable
  rvm install ruby --latest
  rvm --default use ruby
  ruby -v
}
