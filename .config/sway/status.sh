#!/usr/bin/env bash

set -o errexit
set -o pipefail

battery_level() {
  local bat0="$(cat /sys/class/power_supply/BAT0/capacity)"
  local bat1="$(cat /sys/class/power_supply/BAT1/capacity)"

  echo $(( ($bat0 + $bat1) / 2 ))
}

power_status() {
  local is_plugged="$(cat /sys/class/power_supply/AC/online)"
  local bl="$(battery_level)"

  if [[ $is_plugged == "1" ]]; then
    echo 🗲
  elif [[ bl -ge 90 ]]; then
    echo 
  elif [[ bl -ge 80 ]]; then
    echo 
  elif [[ bl -ge 70 ]]; then
    echo 
  elif [[ bl -ge 60 ]]; then
    echo 
  elif [[ bl -ge 50 ]]; then
    echo 
  elif [[ bl -ge 40 ]]; then
    echo 
  elif [[ bl -ge 30 ]]; then
    echo 
  elif [[ bl -ge 20 ]]; then
    echo 
  elif [[ bl -ge 10 ]]; then
    echo 
  else 
    echo 
  fi
}

bluetooth_status() {
  local is_powered="$(bluetoothctl -- show | rg -i 'powered: yes')"
  local devices="$(bluetoothctl -- info | wc -l)" # output will be 1 if no devices connected; >1 otherwise

  if [[ $is_powered ]]; then
    [[ devices -eq 1 ]] && echo  || echo 
  fi
}

network_status() {
  local is_wifi="$(networkctl status wlan0 | rg -i 'online state: online')"
  local is_wired="$(networkctl status enp0s25 | rg -i 'online state: online')"
  
  if [[ $is_wired ]]; then
    echo 
  elif [[ $is_wifi ]]; then
    echo 
  else
    echo 
  fi
}

__datetime() {
  date +"%A %F %R"
}

keyboard_layout() {
  local full_layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "1:1:AT_Translated_Set_2_keyboard") | .xkb_active_layout_name')

  if [[ $full_layout == "English (US)" ]]; then
    echo EN
  elif [[ $full_layout == "Canadian (intl., 1st part)" ]]; then
    echo FR
  fi
}

read_metrics() {
  echo "$(__datetime)" \
    "$(keyboard_layout)" \
    "$(battery_level)"% \
    "$(power_status)" \
    "$(network_status)" \
    "$(bluetooth_status)"
}

while true; do
  read_metrics

  sleep 0.5
done

