#!/bin/sh

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)

synclient PalmDetect=1
synclient PalmMinWidth=3
synclient HorizTwoFingerScroll=0

setxkbmap -option compose:ralt
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
xmodmap -e 'clear mod4' -e 'clear control' -e 'add control = Control_L' -e 'add mod4 = Control_R'

#xsetroot -solid #002b36

nm-applet&
mintupdate-launcher&

dropbox start -i
