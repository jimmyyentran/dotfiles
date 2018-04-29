gnome-terminal -e "bash -c 'printf \"\033]0;Terminal t$(wmctrl -l | grep "Terminal t"| wc -l)\007\"; zsh -c tmux'"
