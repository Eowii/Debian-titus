#!/bin/bash

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf upgrade --refresh -y

# Add base packages

dnf install rofi unzip picom bspwm polybar sddm rofi kitty thunar flameshot neofetch sxhkd git lxpolkit lxappearance feh xsetroot dunst nano -y
dnf install @base-x @firefox -y
dnf install papirus-icon-theme google-noto-emoji-color-fonts fira-code-fonts fontawesome5-fonts-all qt5-qtsvg qt5-qtquickcontrols arandr pavucontrol -y
dnf install qt5-qtgraphicaleffects qt5‑qtquickcontrols2 qt5‑qtsvg -y

wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
dnf install appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm -y

# mscorefonts-ttf
#sudo dnf install curl cabextract xorg-x11-font-utils fontconfig -y
#sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

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
mkdir -p  /home/$username/.local/bin/
cp -R dotfiles/.local /home/$username/
chmod +x /home/$username/.local/bin/*

mkdir -p /home/$username/.config
cp .Xresources /home/$username
cp .Xnord /home/$username
cp -R dotfiles/* /home/$username/.config/
mkdir /home/$username/Pictures/
cd /home/$username/Pictures/
wget https://github.com/Eowii/Windows/raw/main/wallpaper.jpg

sudo mkdir ‑p /usr/share/sddm/themes
cd /usr/share/sddm/themes
git clone https://framagit.org/MarianArlt/sddm-sugar-candy.git/
sudo sed -i 's/#Current=01-breeze-fedora/Current=sddm-sugar-candy/' /etc/sddm.conf


chown -R $username:$username /home/$username

# Boots into graphical UI
sudo systemctl set-default graphical.target
