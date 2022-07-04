headset=alsa_output.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.analog-stereo
volume=$(pactl get-sink-volume $headset | cut -c27-31 | grep -o '[0-9]\+')

if [ $volume -ge 145 ]
	#then pactl -- set-sink-volume 0 150%
	then pactl set-sink-volume $headset 150%
elif [ $volume -lt 145 ]
	#then pactl -- set-sink-volume 0 +5%
	then pactl set-sink-volume $headset +5%
fi
