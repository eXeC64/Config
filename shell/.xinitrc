#!/bin/sh

export PATH=$PATH:$HOME/Scripts
pulseaudio --start
xcompmgr -c &
nm-applet &
feh --bg-scale ~/.wallpaper.jpg
exec i3
