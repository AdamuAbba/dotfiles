# bw_unlock - Unlocks Bitwarden vault and syncs it.
#
# This function runs `bw unlock --raw` to get a session token,
# exports it to BW_SESSION, and runs `bw sync` if successful.
#
# Globals:
#   BW_SESSION - Bitwarden session token
# Returns:
#   0 if unlock succeeds, 1 otherwise
bw_unlock() {
  BW_SESSION=$(bw unlock --raw)
  if [ -n "$BW_SESSION" ]; then
    export BW_SESSION
    echo "Successfully unlocked Bitwarden vault."
    echo "Syncing Bitwarden vault..."
    bw sync
  else
    echo "Failed to unlock Bitwarden vault."
    return 1
  fi
}

# bw_lock - Locks the Bitwarden vault.
#
# Runs `bw lock` to close the vault session.
# Returns:
#   0 if successful
bw_lock() {
  bw lock
}

