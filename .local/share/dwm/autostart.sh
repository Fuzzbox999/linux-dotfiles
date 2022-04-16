#!/bin/sh

# sys_create_env_vars &
pactl set-sink-volume 0 80% &
xinput --disable 11 &
unclutter -idle 3 &
pactl set-source-mute alsa_input.pci-0000_00_1f.3.analog-stereo true &

if [ -z $(pgrep slstatus) ]; then
	slstatus &
else
	true
fi

if [ -z $(pgrep picom) ]; then
	picom --experimental-backends &
else
	true
fi

if [ -z $(pgrep xautolock) ]; then
	xautolock -corners 000- -cornersize 30 -time 30 -locker slock &
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

