#!/bin/sh

sys_create_env_vars &
pactl set-sink-volume 0 50% &
unclutter -idle 3 &

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

#if [ -z $(pgrep udiskie) ]; then
#	udiskie --no-tray &
#else
#	true
#fi

if [ -z $(pgrep devmon) ]; then
	devmon &
else
	true
fi

if [ -z $(pgrep picom) ]; then
	picom &
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
