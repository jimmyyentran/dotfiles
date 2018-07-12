#!/bin/bash

BRIGHTNESS=$(</sys/class/backlight/intel_backlight/brightness)
# echo $BRIGHTNESS
PERCENT=$(echo "($BRIGHTNESS / 1953) * 100" | bc -l)
# echo $PERCENT
volnoti-show -s /usr/share/pixmaps/volnoti/display-brightness-symbolic.svg $PERCENT
