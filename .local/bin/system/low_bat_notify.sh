#!/usr/bin/env bash

# Notifies the user if the battery is low.
# This script is supposed to be called from a cron job.

level=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Exit if not discharging
if [ "${status}" != "Discharging" ]; then
  exit 0
fi

# Source the environment variables required for notify-send to work.
. /home/fuzzbox/.local/etc/env_vars

# Percentage at which to show low-battery notification
low_notif_percentage=30
# Percentage at which to show critical-battery notification
critical_notif_percentage=15
# Percentage at which to power-off
critical_action_percentage=10


if [ "${level}" -le ${critical_action_percentage} ]; then
  notify-send "Le niveau de la batterie est critique: ${level}%"
  exit 0
fi

if [ "${level}" -le ${critical_notif_percentage} ]; then
  notify-send "Le niveau de la batterie est très bas: ${level}%"
  exit 0
fi

if [ "${level}" -le ${low_notif_percentage} ]; then
  notify-send "Le niveau de la batterie est bas: $level%"
  exit 0
fi
