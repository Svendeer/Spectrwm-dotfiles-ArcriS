#!/bin/env bash

# Pequeño script para la barra de estado

Updates(){
    updates="$(pacman -Qqu | wc -l)"
    echo " +@bg=0; +@fg=1;|  $updates"
}

Time(){
    time=$(date +'%H:%M')
    echo " +@bg=1; +@fg=0;  $time"
}

Date(){
	date=$(date +'%a/%d/%b')
	echo " +@bg=0; +@fg=1;  $date"
}

Volume(){
	VOL=$(pamixer --get-volume)
	echo " +@bg=1; +@fg=0;  $VOL%"
}

Brightness(){
	echo " +@bg=0; +@fg=1;  $(light)%"
}

Memory(){
    RAM=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
	echo " +@bg=1; +@fg=0;  $RAM"
}

Network(){
    read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
	if iwconfig $int1 >/dev/null 2>&1; then
	    wifi=$int1
	    eth0=$int2
	else 
	    wifi=$int2
	    eth0=$int1
	fi

    ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 || int=$wifi

    echo -n "+@bg=0; +@fg=1; 泌 $int"

    ping -c1 -s1 8.8.8.8 >/dev/null 2>&1 && echo "Conectado." || echo "Desconectado."
}

while :; do
    echo "$(Updates) $(Time) $(Date) $(Volume) $(Brightness) $(Memory) $(Network)"
	sleep 0.1
done
