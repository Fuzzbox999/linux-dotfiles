#!/bin/sh

KEYS_DIR=/sys/class

echo "4648" | tee $KEYS_DIR/backlight/intel_backlight/brightness && killall -USR1 i3status
# echo "255" | tee $KEYS_DIR/leds/tpacpi::thinklight/brightness
