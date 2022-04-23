#!/bin/bash

username=$(id -u -n 1000)
builddir=$(pwd)

cd ~/betterlockscreen
./install user

betterlockscreen -u ~/Wallpapers/