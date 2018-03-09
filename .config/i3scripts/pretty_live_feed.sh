#!/usr/bin/env bash

time=1
pfps=1.0
previus=$(find ~/Dropbox/pictures/ -type f | wc -l) 
previus=$((previus - 1.0))

while (true) 
	do
		
		val=$(find ~/Dropbox/pictures/ -type f | wc -l)
		
		fps=$((val / time))

		pfps=$(((pfps * 0.95) + ((val - previus) * 0.05) ))

		if [ "$val" -ne "1" ]; then
			bob="files" 
		else
			bob="file"
		fi


		#echo -en "## Currently there is: $val files     |||||     time elapsed: $time            ||||| fps: $fps \r"
		printf "       Currently there is: %20i %s     |||||     time elapsed: %10i           ||||| fps: %10f \r" "$val" "$bob"  "$time" "$pfps" 
		sleep 1
		time=$(($time + 1))
		previus="$val"
	done
