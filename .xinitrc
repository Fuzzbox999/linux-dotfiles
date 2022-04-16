#!/bin/sh

export LANG=fr_FR.UTF-8
setxkbmap fr
systemctl --user import-environment DISPLAY
xrdb $HOME/.Xresources
wal -R
exec dwm
