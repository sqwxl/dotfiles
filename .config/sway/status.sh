#!/usr/bin/env bash

set -o errexit
set -o pipefail

obj() {
  printf "{"
  # $1 is the text
  printf '"full_text": "%s",' "$1"

  # $2 is a boolean for urgent
  "$2" && printf '"urgent": true, "color": "#FF0000",'
  printf '"separator": false,'
  printf "},"
}

ipc() {
  printf "["
  for o in "$@"; do
    printf "$o"
  done
  printf "],"

  echo
}


battery_level() {
  local bat0="$(cat /sys/class/power_supply/BAT0/capacity)"
  local bat1="$(cat /sys/class/power_supply/BAT1/capacity)"

  echo $(( ($bat0 + $bat1) / 2 ))
}

power_status() {
  local is_plugged="$(cat /sys/class/power_supply/AC/online)"
  local bl="$(battery_level)"

  local status="$bl%%"
  local symbol=🗲
  local urgent=false
  if [[ $is_plugged == "0" ]]; then
    if [[ $bl -ge 90 ]]; then
      symbol=
    elif [[ $bl -ge 80 ]]; then
      symbol=
    elif [[ $bl -ge 70 ]]; then
      symbol=
    elif [[ $bl -ge 60 ]]; then
      symbol=
    elif [[ $bl -ge 50 ]]; then
      symbol=
    elif [[ $bl -ge 40 ]]; then
      symbol=
    elif [[ $bl -ge 30 ]]; then
      symbol=
    elif [[ $bl -ge 20 ]]; then
      symbol=
    elif [[ $bl -ge 10 ]]; then
      symbol=
    else 
      symbol=
      urgent=true
    fi
  elif [[ $bl -ge 99 ]]; then
    symbol=🗲
  elif [[ $bl -ge 90 ]]; then
    symbol=
  elif [[ $bl -ge 80 ]]; then
    symbol=
  elif [[ $bl -ge 60 ]]; then
    symbol=
  elif [[ $bl -ge 40 ]]; then
    symbol=
  elif [[ $bl -ge 30 ]]; then
    symbol=
  else
    symbol=
  fi

  obj "$status $symbol" $urgent
}

bluetooth_status() {
  local is_powered="$(bluetoothctl -- show | rg -i 'powered: yes')"
  local devices="$(bluetoothctl -- info | wc -l)" # output will be 1 if no devices connected; >1 otherwise

  if [[ $is_powered ]]; then
    [[ devices -eq 1 ]] && obj  || obj  
  fi
}

network_status() {
  local is_wifi="$(networkctl status wlan0 | rg -i 'online state: online')"
  local is_wired="$(networkctl status enp0s25 | rg -i 'online state: online')"
  
  if [[ $is_wired ]]; then
    obj 
  elif [[ $is_wifi ]]; then
    obj 
  else
    obj 
  fi
}

time_status() {
  obj "$(date +"%A %F %R")"
}

keyboard_status() {
  local full_layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "1:1:AT_Translated_Set_2_keyboard") | .xkb_active_layout_name')

  if [[ $full_layout == "English (US)" ]]; then
    obj EN
  elif [[ $full_layout == "Canadian (intl., 1st part)" ]]; then
    obj FR
  fi
}

read_metrics() {
  ipc "$(time_status)" \
    "$(keyboard_status)" \
    "$(power_status)" \
    "$(network_status)" \
    "$(bluetooth_status)"
}

printf '{"version": 1}\n'
printf "["
while true; do
  read_metrics

  sleep 0.5
done

