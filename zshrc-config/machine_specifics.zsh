unameOut="$(uname -s)"
machine=""

case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [[ "$machine" == "Mac" ]]; then
  source $HOME/zshrc-config/macOS.zsh
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  source $HOME/zshrc-config/linux.zsh
fi

