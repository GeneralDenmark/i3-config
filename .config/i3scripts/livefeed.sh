#!/usr/bin/env bash



main() {
	while (true) 
	do
		
		val=$(find ~/Dropbox/pictures/ -type f | wc -l)

		val=$(($val - 198))

		echo -en "Currently there is: $val files \r"
		
		sleep 1
	done
}
main