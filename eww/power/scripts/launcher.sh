cd "$(head -1 ~/.config/eww/power/directory.txt)"

./eww close-all
./eww open poweroff
./eww open restart
./eww open log_out
./eww open lock
./eww open close