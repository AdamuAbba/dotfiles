  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"

#========================= update python ============================================
update_python ()
{
# Update pyenv to ensure it has the latest list of Python versions
echo "Updating pyenv..."
cd "$(pyenv root)" && git pull

# Find the latest stable Python version
echo "Finding the latest stable Python version..."
latest_version=$(pyenv install --list | grep -E '^\s*[0-9]+\.[0-9]+\.[0-9]+$' | tail -n 1 | tr -d ' ')

# Install the latest version if not already installed
echo "Installing Python $latest_version..."
pyenv install -s "$latest_version"

# Set the latest version as the global default
echo "Setting Python $latest_version as the global version..."
pyenv global "$latest_version"

# Verify the global Python version
echo "Python $latest_version is now set as the global version."
python --version
}
