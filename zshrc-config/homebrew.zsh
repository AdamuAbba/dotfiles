unameOut="$(uname -s)"
machine=""

case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [[ "$machine" == "Mac" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_AUTO_UPDATE=1
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
