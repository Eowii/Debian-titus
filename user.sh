#!/bin/bash

cd ~/betterlockscreen
./install.sh user

betterlockscreen -u ~/Wallpapers/wallpaper.jpg

#Sets the volume to 100%
pactl -- set-sink-volume 0 100%


sed -i 's/bash ~\/user.sh//' ~/.config/bspwm/bspwmrc
rm ~/user.sh