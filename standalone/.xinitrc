#          _      _ __
#   __ __ (_)__  (_) /_________
#   \ \ // / _ \/ / __/ __/ __/
#  /_\_\/_/_//_/_/\__/_/  \__/

# A modified version of:
# https://unix.stackexchange.com/questions/253489/
# how-to-set-the-keymap-for-keyboards-that-are-plugged-in-later
{ echo "Keyboard" && inputplug -d -c /bin/echo; } |
while read event
do
    if [[ "$event" == *"Keyboard"* ]]; then
        setxkbmap \
            -layout us,ru \
            -option grp:win_space_toggle \
            -option compose:ralt
    fi
done &

eval $(ssh-agent)           # Start the SSH agent.
compfy -b                   # Start the window compositor.
~/.fehbg                    # Set the wallpaper.
exec dbus-launch bspwm      # Start the bspwm window manager.
dunst &                     # Start the dunst notification manager.
xset -dpms                  # Disable the display power management signaling.
xset s off                  # Disable the screensaver.

