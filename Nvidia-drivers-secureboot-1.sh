#!/bin/bash

# Install mokutil and openssl
sudo dnf install mokutil openssl

#Generate a signing key
sudo openssl req -new -x509 -newkey rsa:2048 -keyout ~/driver-signing.key -outform DER -out ~/driver-signing.der -nodes -days 36500 -subj "/CN=Private Driver Signing"


#Initiate the key enrollment
echo "Typ a password and remember it, need to use it on next boot"
sudo mokutil --import ~/driver-signing.der

#Reboot to enroll the key
sudo reboot