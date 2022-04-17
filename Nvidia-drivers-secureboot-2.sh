#!/bin/bash

# Enable 2 COPRs
sudo dnf copr enable egeretto/kmodtool-secureboot -y
sudo dnf copr enable egeretto/akmods-secureboot -y
sudo dnf update --refresh

# Install the modified versions of kmodtool and akmods
sudo dnf install kmodtool akmods -y

#Move the public and private parts of the key to the akmods dir and set secure permissions
sudo mv ~/driver-signing.der /etc/pki/akmods/certs/public_key.der
sudo chown root:akmods /etc/pki/akmods/certs/public_key.der
sudo chmod 640 /etc/pki/akmods/certs/public_key.der
sudo mv ~/driver-signing.key /etc/pki/akmods/private/private_key.priv
sudo chown root:akmods /etc/pki/akmods/private/private_key.priv
sudo chmod 640 /etc/pki/akmods/private/private_key.priv


# Install NVidia driver
sudo dnf install gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs.i686 -y

# Make sure the kernel modules got compiled
sudo akmods --force

# Make sure the boot image got updated as well
sudo dracut --force

# Reboot your device
sudo reboot
