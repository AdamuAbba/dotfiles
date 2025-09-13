export GEMINI_API_KEY="$(security find-generic-password -a "$USER" -s gemini_api_key -w 2>/dev/null)"
