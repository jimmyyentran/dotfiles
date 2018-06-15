#!/bin/bash
unset x y w h
eval $(xwininfo -id $(xdotool search --onlyvisible --class $1 | sed -n 1p) |
    sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
    -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
    -e "s/^ \+Width: \+\([0-9]\+\).*/w=\1/p" \
    -e "s/^ \+Height: \+\([0-9]\+\).*/h=\1/p" )
# echo -n "$x $y $w $h"
xpos=$(($x + $w / 2))
ypos=$(($y + $h / 2))
xdotool mousemove $xpos $ypos

