#!/bin/bash
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export DISPLAY=:0


notify-send "$1" "$2"
