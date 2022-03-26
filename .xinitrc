#          _      _ __         
#   __ __ (_)__  (_) /_________
#   \ \ // / _ \/ / __/ __/ __/
#  /_\_\/_/_//_/_/\__/_/  \__/ 
#                              

eval $(ssh-agent)
setxkbmap -option compose:ralt
setxkbmap -layout us,ru -option grp:win_space_toggle
# wal -R
picom &
~/.fehbg
# feh --bg-fill ~/images/wallpapers/wallhaven-281k9yng ~/images/wallpapers/wallhaven-281k9yng
xrandr --output DP-1-3 --mode 3840x2160 --primary --output eDP-1 --left-of DP-1-3
exec dbus-launch bspwm

