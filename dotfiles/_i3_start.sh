#!/bin/sh

synclient PalmDetect=1
synclient PalmMinWidth=3
synclient HorizTwoFingerScroll=1

setxkbmap gb
setxkbmap -option compose:ralt
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
xmodmap -e 'clear mod4' -e 'clear control' -e 'add control = Control_L' -e 'add mod4 = Control_R'

xrdb ~/.Xresources
xrandr --dpi 100

#nosleep
xset -dpms
xset s noblank
xset s off
