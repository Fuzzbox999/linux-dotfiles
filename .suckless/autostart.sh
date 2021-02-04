#!/bin/sh

create_env_vars &
pactl set-sink-volume 0 50% &

if [ -z $(pgrep cpuload) ]; then
	cpuload &
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

if [ -z $(pgrep picom) ]; then
	picom --vsync --blur-background --active-opacity 1.0 --backend glx --opacity-rule "95:class_g = 'URxvt'" --opacity-rule "95:class_g = 'st-256color'" --opacity-rule "85:class_g = 'dmenu'" --opacity-rule "95:class_g = 'dwm'" -c -e 1.0 -i 0.9 -o 1.0 -D 6 --xinerama-shadow-crop -C &
	# picom --vsync --blur-background --active-opacity 1.0 --backend glx -c -e 1.0 -i 1.0 -o 1.0 -D 6 --xinerama-shadow-crop -C &
else
	true
fi

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

if [ -z $(pgrep clipmenud) ]; then
	clipmenud &
else
	true
fi

# i3lock_custom &
