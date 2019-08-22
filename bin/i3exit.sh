#!/usr/bin/env bash

lock() {
    i3lock -c 000000 -e -f
}

case "$1" in
    lock)
        i3lock-fancy -f Helvetica-Bold && xset dpms force off
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        i3lock-fancy -f Helvetica-Bold && systemctl suspend
        # lock && sleep 1 && systemctl suspend
        # systemctl suspend
        ;;
    hibernate)
        systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 [lock|logout|suspend|hibernate|reboot|shutdown]"
        exit 2
esac

exit 0
