#!/bin/bash

speakername=alsa_output.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.analog-stereo

pactl unload-module module-remap-sink
pactl load-module module-remap-sink sink_name=media-sound sink_properties=device.description=Media_Sound master=$speakername
pactl load-module module-remap-sink sink_name=standard-sound sink_properties=device.description=Standard_Sound master=$speakername
pactl load-module module-remap-sink sink_name=voip-sound sink_properties=device.description=VoIP_Sound master=$speakername

pactl set-default-sink standard-sound
