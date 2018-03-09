#!/usr/bin/env bash


for ((i=1;i<=255;i++)); 
do
	ip="172.26.88.$i"
	if ping -c 1 "$ip" &> /dev/null
		then
			echo "$ip"
			exec ssh-copy-id user@"$ip"
	fi
done
