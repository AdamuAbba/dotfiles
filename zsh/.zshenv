# This file is sourced by *all* zsh sessions, including non-interactive ones.
# ONLY pure environment variables here. No prompts, aliases, or OMZ.

#============================================ Lang ====================
# --- Go ---
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# --- Javascript ---
export NVM_DIR="$HOME/.nvm"

# --- Java ---

# --- Android SDK ---

# --- Rust ---
. "$HOME/.cargo/env"

# --- ruby ---

#============================================ atac ==============================================
ATAC_MAIN_DIR="$HOME/.config/atac/"
export ATAC_THEME="$ATAC_MAIN_DIR/themes/dracula_theme.toml"
export ATAC_KEY_BINDINGS="$ATAC_MAIN_DIR/key_bindings/vim_key_bindings.toml"
