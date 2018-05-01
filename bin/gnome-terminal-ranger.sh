gnome-terminal --hide-menubar --window-with-profile=ranger -e "bash -c 'printf \"\033]0;Terminal r$(wmctrl -l | grep "Terminal r"| wc -l)\007\"; ranger'"
