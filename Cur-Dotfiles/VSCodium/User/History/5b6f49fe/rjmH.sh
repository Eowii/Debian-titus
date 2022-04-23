#!/usr/bin/env bash

w_class=$2
w_id=$1
w_instance=$3
w_name1=$(xprop -id $w_id WM_NAME)
w_name=`echo "$w_name1" | cut -d'"' -f 2`



echo -e "Name:$w_name\nID:$w_id\nInstance:$w_instance\nClass:$w_class" > ~/test.txt

#*"("*")"

# ----------------------------------------
# Windows State
# ----------------------------------------

# Thunderbird About Window
#if [[ "$w_name" =~ "About" ]]; then
#  printf "state=floating"
#fi

# Android Emulator
#if [[ "$w_name" =~ "Android Emulator" ]]; then
#  printf "state=floating"
#fi

# ----------------------------------------
# Move to Desktop
# ----------------------------------------

#if [[ "$w_class" =~ "Gimp" ]]; then
#  printf "desktop=^5"
#fi

if [[ "$w_name" == "Friends List" ]] && [[ "$w_instance" == "Steam" ]]; then   
 	echo "desktop=^11"
	echo "split_dir=east"
	echo "rectangle=400x1080+2160+0"
	echo "state=floating"
fi

if [[ "$w_name" == "TeamSpeak 3" ]]; then   
 	echo "desktop=^11"
	echo "split_dir=east"
	echo "state=floating"
	echo "rectangle=400x1080+1672+0"
fi

if [[ "$w_name" == "Discord" ]]; then   
 	echo "desktop=^3"
	echo "split_dir=east"
	#echo "rectangle=1176x1080+0+0"
	#echo "state=floating"
fi

if [[ "$w_name" == *"("*")" ]] && [[ "$w_instance" == "Steam" ]]; then   
 	echo "desktop=^11"
	echo "split_dir=east"
	echo "state=pseudo_tiled"
	echo "rectangle=400x540+1725+540"
fi

if [[ "$w_name" == "Steam" ]] && [[ "$w_instance" == "Steam" ]]; then   
 	echo "desktop=^2"
fi

if [[ "$w_name" == "WM_NAME:  not found." ]]; then   
 	echo "desktop=^5"
fi


FIFA 22 - Steam
if [[ "$w_name" == "FIFA 22 - Steam" ]]; then   
 	echo "desktop=^2"
	echo "state=floating"
fi

if [[ "$w_class" == "steam_app_"* ]]; then   
 	echo "desktop=^10"
	echo "state=fullscreen"
fi

if [[ "$w_class" == "csgo_linux64" ]]; then   
 	echo "desktop=^10"
	echo "state=fullscreen"
fi

#if [[ "$w_name" == "Steam" ]]; then   
# 	echo "state=floating"
#fi

#if [[ "$w_instance" == "Steam" ]]; then   
# 	echo "state=floating"
#fi