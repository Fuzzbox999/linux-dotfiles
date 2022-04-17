#!/bin/sh

# This file is run by a ranger shortcut right after running Pywwal.
# It updates the dunstrc config file with the new colors and reload dunst.

. "${HOME}/.cache/wal/colors.sh"

sed -i"" --follow-symlinks \
        -e "s/frame_color = .*/frame_color = \"${color7:-#FFFFFF}\"/" \
	-e "s/foreground = .*/foreground = \"${color7:-#FFFFFF}\"/" \
	-e "s/background = .*/background = \"${color0:-#FFFFFF}\"/" \
	"${HOME}/.config/dunst/dunstrc"

pkill dunst
dunst -config ~/.config/dunst/dunstrc &
