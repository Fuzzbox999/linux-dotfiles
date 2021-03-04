#!/usr/bin/env bash

# Create a new file containing the values of the environment variables
# required for cron scripts to work.
# This script is supposed to be scheduled to run at startup.

env_vars_path="$HOME/.local/etc/env_vars"

rm -f "${env_vars_path}"
touch "${env_vars_path}"
chmod 600 "${env_vars_path}"

# Array of the environment variables.
env_vars=("DBUS_SESSION_BUS_ADDRESS" "XAUTHORITY" "DISPLAY")

for env_var in "${env_vars[@]}"
do
    echo "$env_var"
    env | grep "${env_var}" >> "${env_vars_path}";
    echo "export ${env_var}" >> "${env_vars_path}";
done
