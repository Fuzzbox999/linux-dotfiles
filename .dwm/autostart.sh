#!/bin/sh

# dwmbar &

if [ -z $(pgrep cpuload_percent) ]; then
	cpuload_percent &
else
	true
fi

if [ -z $(pgrep dwmblocks) ]; then
	dwmblocks &
else
	true
fi

if [ -z $(pgrep udiskie) ]; then
	udiskie --no-tray &
else
	true
fi

create_env_vars &

picom --vsync --blur-background --active-opacity 1.0 --backend glx --opacity-rule "90:class_g = 'URxvt'" --opacity-rule "80:class_g = 'dmenu'" --opacity-rule "80:class_g = 'dwm'" -c -e 1.0 -i 0.9 -o 1.0 -D 6 --xinerama-shadow-crop -C &

if [ -z $(pgrep xautolock) ]; then
	xautolock -corners 000- -cornersize 30 -time 30 -locker i3lock_custom &
else
	true
fi

if [ -z $(pgrep redshift) ]; then
	redshift -l 48.49:2.3 -t 5500:3500 &
else
	true
fi

pactl set-sink-volume 0 50% &

if [ -z $(pgrep clipmenud) ]; then
	clipmenud &
else
	true
fi

# i3lock_custom &

