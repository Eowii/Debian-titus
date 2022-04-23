#!/bin/bash

username=$(id -u -n 1000)
builddir=$(pwd)

cd /home/$username/betterlockscreen
su - $username -c "./install user"
cd /home/$username/

betterlockscreen -u ~/Wallpapers/