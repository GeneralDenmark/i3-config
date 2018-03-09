#!/usr/bin/env bash

BATTINFO=`acpi -b`
title="Test"
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:30:00 ]] ; then
    title="Battery Low"
elif [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:15:00  ]]; then
	title="Critical Battery"

fi
echo "bob"
twmnc --title "$title" --content "Down to $BATTINFO" 