#!/bin/bash

username=$(id -u -n 1000)
builddir=$(pwd)

#cd ~/betterlockscreen
#./install.sh user

#betterlockscreen -u ~/Wallpapers/wallpaper.jpg

#Sets the volume to 100%
pactl -- set-sink-volume 0 100%


sed -i 's/bash ~\/user.sh//' ~/.config/bspwm/bspwmrc
cd ~
rm -rf user.sh betterlockscreen eww fedora i3lock-color Vimix-cursors

firefox -headless & sleep 1
killall firefox
sleep 0.5
killall firefox

ln -sf /home/$username/GitHub/Fedora/user.js /home/$username/.mozilla/firefox/*.default-release/
