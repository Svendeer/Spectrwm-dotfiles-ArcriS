#!/bin/env bash

Music(){
    song=$(cmus-remote -Q | awk '/tag title/  {$1=$2=""; t=$0} END {print b t}')
    echo $song
}

Updates(){
    updates="$(pacman -Qqu | wc -l)"
    echo $updates
}

Time(){
    time=$(date +'%H:%M')
    echo $time
}

Date(){
	date=$(date +'%A/%d/%B/%Y')
	echo $date
}

Volume(){
	VOL=$(pamixer --get-volume)
	echo $VOL%
}

Brightness(){
	echo $(light)%
}

Memory(){
    RAM=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
	echo $RAM
}

while :; do
    echo " +@bg=1;  $(Music) +@bg=2;  $(Updates) +@bg=1;  $(Time) +@bg=2;  $(Date) +@bg=1;  $(Volume) +@bg=2;  $(Brightness) +@bg=1;  $(Memory) "
	sleep 0.1
done
