#!/usr/bin/env bash

IN="$(ps auxf | awk '{if ($13 != "" && $13 !~ /^-/) print $3" "$13; else if ( $12 != "" && $12 !~ /^-/) print $3" "$12; else if ($11 != "" ) print $3" "$11; }' | tr -d "%CPU" | tr -d "COMMAND")"

index=0
jdex=3
mails=""
toggle=0
largestName=""
largest=0.0

for temp in $IN 
do
	if [ $index != 1 ] ; then
		if (( $(echo "$temp > $largest" | bc -l))) ; then

			largest=$temp
			toggle=1
		fi

		index=1

	else

		if [ $toggle != 0 ] ; then
			
			toggle=0
			largestName=$temp
		fi
		index=0
	fi
	
done



echo " $largest% $(echo $largestName | awk '{ if ($1 != "\\_") print $1; else "bash" }' | sed 's@.*/@@' )"
