#!/bin/bash

username=$(id -u -n 1000)
builddir=$(pwd)

cd ~/betterlockscreen
./install.sh user

betterlockscreen -u ~/Wallpapers/wallpaper.jpg