#!/bin/sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
# xrandr --dpi 250

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

[[ -f ~/.xprofile ]] && . ~/.xprofile
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

picom -b & 
xbindkeys 

dunst -config ~/.config/dunst/dunstrc &


xmonad &
xmonad_pid=$!

xrandr --auto --output HDMI-1-0 --mode 3840x2160 --left-of eDP-1
feh --bg-fill ~/Pictures/WPs/night.png
xsetroot -cursor_name left_ptr

wait $xmonad_pid
