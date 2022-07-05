#!/bin/bash

username=$(id -u -n 1000)
builddir=$(pwd)

echo "fastestmirror=1" >> /etc/dnf/dnf.conf
echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf

# Update packages list
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf copr enable gloriouseggroll/nobara -y
dnf copr enable gloriouseggroll/mesa-aco -y
dnf copr enable gloriouseggroll/glibc -y
dnf copr enable gloriouseggroll/game-utils -y
dnf copr enable gloriouseggroll/openal-soft -y
dnf copr enable gloriouseggroll/edk2 -y
dnf copr enable gloriouseggroll/obs-studio-gamecapture -y
dnf copr enable sentry/kernel-fsync -y
dnf copr enable sentry/xone -y

#VSCodium
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo



dnf upgrade --refresh -y

# Add base packages

#dnf install rofi yad unzip picom bspwm polybar sddm rofi kitty thunar flameshot neofetch sxhkd git lxpolkit lxappearance feh xsetroot dunst nano xset -y
#dnf install @base-x @firefox -y
#dnf install papirus-icon-theme google-noto-emoji-color-fonts fira-code-fonts fontawesome5-fonts-all qt5-qtsvg qt5-qtquickcontrols arandr pavucontrol -y
#dnf install autoconf automake cairo-devel fontconfig gcc libev-devel libjpeg-turbo-devel libXinerama libxkbcommon-devel libxkbcommon-x11-devel libXrandr pam-devel pkgconf xcb-util-image-devel xcb-util-xrm-devel -y
#dnf install qt5-qtgraphicaleffects -y
#dnf install vdpauinfo libva-vdpau-driver libva-utils -y
#dnf install xcursorgen python-cairosvg -y
#dnf install winetricks protontricks gamemode -y

dnf install $(cat install-packages.txt) -y
dnf install $(cat nobara-installed.txt) -y

#Installing flatpaks
flatpak install $(cat install-flatpak.txt) -y

#Appimage Launcher
wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
dnf install appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm -y

#GitHub-Desktop
wget https://github.com/shiftkey/desktop/releases/download/release-3.0.0-linux2/GitHubDesktop-linux-3.0.0-linux2.rpm
dnf install GitHubDesktop-linux-3.0.0-linux2.rpm -y

#VSCodium
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo

#BitWarden
mkdir -p /home/$username/AppImg
cd /home/$username/AppImg
wget https://github.com/bitwarden/desktop/releases/download/v2022.5.1/Bitwarden-2022.5.1-x86_64.AppImage


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
#cp -R dotfiles/* /home/$username/.config/
cp gamemode.ini /usr/share/gamemode/
mkdir /home/$username/Wallpapers/
cp $builddir/wallpaper.jpg /home/$username/Wallpapers/


mkdir /home/$username/GitHub/Fedora/ -p
cp -R $builddir/. /home/$username/GitHub/Fedora/

#cp -R $builddir/dotfiles/* /home/$username/GitHub/Fedora/dotfiles/

cd /home/$username/.config

FILES="/home/$username/GitHub/Fedora/dotfiles/*"
for f in $FILES
do
  ln -sf $f
  echo "Processing $f file..."
done

cd /home/$username/
ln -sf /home/$username/GitHub/Fedora/.bashrc


sudo sed -i 's/#User=/User='$username'/' /etc/sddm.conf
sudo sed -i 's/#Session=/Session=bspwm/' /etc/sddm.conf



#Removes mouse accel
 echo "Section \"InputClass\"
        Identifier \"My Mouse\"
        MatchIsPointer \"yes\"
        Option \"AccelerationProfile\" \"-1\"
        Option \"AccelerationScheme\" \"none\"
        Option \"AccelSpeed\" \"-1\"
EndSection" > /etc/X11/xorg.conf.d/50-mouse-acceleration.conf

cd /home/$username/
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh

cd /home/$username/
git clone https://github.com/betterlockscreen/betterlockscreen
cd betterlockscreen
#su - $username -c "./install user"


cd /home/$username/
git clone https://github.com/vinceliuice/Vimix-cursors
cd Vimix-cursors
./install.sh

curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y
source $HOME/.cargo/env


cd /home/$username/
git clone https://github.com/elkowar/eww
cd eww
cargo build --release
cd target/release
mv eww /usr/bin/eww

cd $builddir
cp user.sh /home/$username/

echo "bash ~/user.sh" >> /home/$username/.config/bspwm/bspwmrc

chown -R $username:$username /home/$username

# Boots into graphical UI
sudo systemctl set-default graphical.target


echo ">>>>>> Reboot and run user.sh as your user. <<<<<<"
echo ">>>>>> Reboot and run user.sh as your user. <<<<<<"
echo ">>>>>> Reboot and run user.sh as your user. <<<<<<"
#cd $builddir
#su - $username -c "./user.sh"
