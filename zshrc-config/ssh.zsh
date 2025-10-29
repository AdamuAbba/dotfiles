gen_ssh_key() {
  if [ -z "$1" ]; then
    echo "Usage: genkey <name>"
    return 1
  fi

  local KEY_NAME="id_ed25519_$1"
  local EMAIL="abbaadamu302@gmail.com"
  local KEY_PATH="$HOME/.ssh/$KEY_NAME"

  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
  chmod 600 "$KEY_PATH"

  echo "Key generated at: $KEY_PATH"
}
