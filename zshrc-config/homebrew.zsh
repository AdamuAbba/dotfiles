eval "$(/opt/homebrew/bin/brew shellenv)"

export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_AUTO_UPDATE=0
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"
export C_INCLUDE_PATH="/opt/homebrew/include:$C_INCLUDE_PATH"
