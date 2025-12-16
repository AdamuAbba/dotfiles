export GEMINI_API_KEY="$(security find-generic-password -a "$USER" -s gemini_api_key -w 2>/dev/null)"
export GITHUB_TOKEN="$(security find-generic-password -a "$USER" -s github_token -w 2>/dev/null)"
