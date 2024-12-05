#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
picom --config $HOME/.config/picom_conf/1.conf &
nitrogen --restore &
dunst -config $HOME/.config/script/dunstrc &
setxkbmap -model pc105 -layout us,ru -variant qwerty -option grp:alt_shift_toggle
xrandr --output DP-1 --primary --mode 2560x1440 --rate 144 --below DP-2 --output DP-2 --mode 2560x1440 --rate 143.97

while true; do
    ubar
    sleep 0.3
done &

while true;do
    exec dwm 2> ~/.dwm.log
done
