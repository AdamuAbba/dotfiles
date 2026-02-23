#!/usr/bin/env bash
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

command="$(spotify_player playback play)"

if [ -z "$command" ]; then
  prompt='Online'
  mesg="spotify_player is online"
else
  prompt='Offline'
  mesg="spotify_player is offline"
fi

if [[ ("$theme" == *'type-1'*) || ("$theme" == *'type-3'*) || ("$theme" == *'type-5'*) ]]; then
  list_col='1'
  list_row='6'
elif [[ ("$theme" == *'type-2'*) || ("$theme" == *'type-4'*) ]]; then
  list_col='6'
  list_row='1'
fi

# Options
layout=$(cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2)
if [[ "$layout" == 'NO' ]]; then
  option_1=" Play"
  option_1=" Pause"
  option_2=" Stop"
  option_3=" Previous"
  option_4=" Next"
  option_5=" Repeat"
  option_6=" Random"
else
  option_1=""
  option_1=""
  option_2=""
  option_3=""
  option_4=""
  option_5=""
  option_6=""
fi

# Rofi CMD
rofi_cmd() {
  rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    ${active} ${urgent} \
    -markup-rows \
    -theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Execute Command
run_cmd() {
  if [[ "$1" == '--opt1' ]]; then
    spotify_player playback play-pause
  elif [[ "$1" == '--opt2' ]]; then
    spotify_player playback pause
  elif [[ "$1" == '--opt3' ]]; then
    spotify_player playback previous
  elif [[ "$1" == '--opt4' ]]; then
    spotify_player playback next
  elif [[ "$1" == '--opt5' ]]; then
    spotify_player playback repeat
  elif [[ "$1" == '--opt6' ]]; then
    spotify_player playback shuffle
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$option_1)
  run_cmd --opt1
  ;;
$option_2)
  run_cmd --opt2
  ;;
$option_3)
  run_cmd --opt3
  ;;
$option_4)
  run_cmd --opt4
  ;;
$option_5)
  run_cmd --opt5
  ;;
$option_6)
  run_cmd --opt6
  ;;
esac
