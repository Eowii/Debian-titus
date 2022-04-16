#!/bin/bash

# Change Debian to SID Branch

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf upgrade --refresh -y

# Add base packages

dnf install rofi unzip picom bspwm polybar sddm rofi kitty thunar flameshot neofetch sxhkd git lxpolkit lxappearance feh xsetroot -y
dnf install @base-x -y
dnf install papirus-icon-theme google-noto-emoji-color-fonts fira-code-fonts fontawesome5-fonts-all qt5-qtsvg qt5-qtquickcontrols -y

# mscorefonts-ttf
sudo dnf install curl cabextract xorg-x11-font-utils fontconfig -y
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Fira Code Nerd Font variant needed
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts
fc-cache -vf

cd $builddir
mkdir -p /home/$username/.config
cp .Xresources /home/$username
cp .Xnord /home/$username
cp -R dotfiles/* /home/$username/.config/
mkdir /home/$username/Pictures/
cd /home/$username/Pictures/
wget https://github.com/Eowii/Windows/raw/main/wallpaper.jpg
cd /home/$username/
git clone https://github.com/Eayu/sddm-theme-clairvoyance
sudo mv sddm-theme-clairvoyance /usr/share/sddm/themes/clairvoyance
sudo cp /etc/sddm.conf /etc/sddm2.conf
sudo sed -i 's/#Current=01-breeze-fedora/Current=clairvoyance' /etc/sddm.conf


chown -R $username:$username /home/$username

# Boots into graphical UI
sudo systemctl set-default graphical.target