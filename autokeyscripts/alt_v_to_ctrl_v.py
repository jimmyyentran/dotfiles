# Enter script code
winClass = window.get_active_class()
if '.Gnome-terminal' in winClass:
    keyboard.send_keys("<ctrl>+<shift>+v")
else:
    keyboard.send_keys("<ctrl>+v")