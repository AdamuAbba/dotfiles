export GITHUB_TOKEN="$(security find-generic-password -a "$USER" -s github_token -w 2>/dev/null)"
