#          _      _ __         
#   __ __ (_)__  (_) /_________
#   \ \ // / _ \/ / __/ __/ __/
#  /_\_\/_/_//_/_/\__/_/  \__/ 
#                              

eval $(ssh-agent)
setxkbmap -option compose:ralt
setxkbmap -layout us,ru -option grp:win_space_toggle
picom -b --experimental-backends
~/.fehbg
exec dbus-launch bspwm
xset -dpms
xset s off

