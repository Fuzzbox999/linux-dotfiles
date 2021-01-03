#!/bin/sh

KEYS_DIR=/sys/class/backlight/intel_backlight

test -d $KEYS_DIR || exit 0

MIN=0
MAX=$(cat $KEYS_DIR/max_brightness)
VAL=$(cat $KEYS_DIR/actual_brightness)

if [ "$1" = down ]; then
	VAL=$((VAL-332))
elif [ "$1" = up ]; then
	VAL=$((VAL+332))
else
	VAL=$VAL
fi

if [ "$VAL" -lt $MIN ]; then
	VAL=$MIN
elif [ "$VAL" -gt $MAX ]; then
	VAL=$MAX
fi

echo $VAL | tee $KEYS_DIR/brightness && killall -USR1 i3status
