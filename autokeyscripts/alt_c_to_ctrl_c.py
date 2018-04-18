# Enter script code
winClass = window.get_active_class()
if '.Gnome-terminal' in winClass:
    keyboard.send_keys("<ctrl>+<shift>+c")
else:
    keyboard.send_keys("<ctrl>+c")