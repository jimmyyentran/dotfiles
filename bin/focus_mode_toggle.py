#!/usr/bin/env python
import subprocess

xrandr_output = subprocess.run(['xrandr'], stdout=subprocess.PIPE).stdout.decode('utf-8')

NORMAL = "xrandr --output DP-2 --auto --left-of DP-4 --output DP-4 --primary --auto --output DP-0 --auto --right-of DP-4 --output HDMI-1 --auto --above DP-4".split(' ')
FOCUS = "xrandr --output DP-2 --off --left-of DP-4 --output DP-4 --primary --auto --output DP-0 --off --right-of DP-4 --output HDMI-1 --off --above DP-4".split(' ')

all_on = True
for line in xrandr_output.split('\n'):
    if not line:
        continue
    words = line.split(" ")
    if words[1] == "connected" and words[2][0] == '(':
        print(f"Monitor {words[0]} is off. Returning to normal")
        all_on = False
        break

if all_on:
    subprocess.run(FOCUS)
else:
    subprocess.run(NORMAL)
