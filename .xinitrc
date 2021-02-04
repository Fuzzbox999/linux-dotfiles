#!/bin/sh

systemctl --user import-environment DISPLAY
xrdb $HOME/.Xresources
wal -R
exec dwm
