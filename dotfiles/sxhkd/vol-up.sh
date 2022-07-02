volume=$(pactl get-sink-volume 0 | cut -c27-31 | grep -o '[0-9]\+')
if [ $volume -ge 145 ]
	then pactl -- set-sink-volume 0 150%
elif [ $volume -lt 145 ]
	then pactl -- set-sink-volume 0 +5%
fi
