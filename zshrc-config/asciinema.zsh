ascii_upload() {
  local file
  file=$(find "$SCREEN_RECORDING_DIR" -type f -name '*.cast' \
    | awk -F/ '{print $NF "\t" $0}' \
    | fzf --with-nth=1 --delimiter='\t' --preview='asciinema play {2}' \
    | cut -f2) || return

  asciinema upload "$file"
}

ascii_play() {
  local file
  file=$(find "$SCREEN_RECORDING_DIR" -type f -name '*.cast' \
    | awk -F/ '{print $NF "\t" $0}' \
    | fzf --with-nth=1 --delimiter='\t' --preview='asciinema play {2}' \
    | cut -f2) || return

  asciinema play "$file"
}

ascii_rec() {
  local filename
  read "filename?Enter recording name: "
  filename="${filename%.cast}.cast"
  asciinema rec "$SCREEN_RECORDING_DIR/$filename"
}

ascii_delete() {
  local files
  files=$(find "$SCREEN_RECORDING_DIR" -type f -name '*.cast' \
    | awk -F/ '{print $NF "\t" $0}' \
    | fzf --with-nth=1 --delimiter='\t' --multi \
    | cut -f2) || return

  [[ -n "$files" ]] && echo "$files" | xargs -I{} rm -v "{}"
}
