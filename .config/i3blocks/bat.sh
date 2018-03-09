#!/bin/bash 

Bat=$(acpi | cut -d " " -f4 | tr -d "%,")
Ext=$(acpi | awk '{split($5,a,":"); if($5==" "||$5=="") ; else print a[1]"h "a[2]"m"}')
Adapt=$(acpi -a | cut -d " " -f3)

ischarging=0

if [ "$Adapt" = "on-line" ];then
	icon0=""
    icon1=""
    icon2=""
    icon3=""
    icon4=""
    ischarging=1
else
    icon0=""
    icon1=""
    icon2=""
    icon3=""
    icon4=""
fi

if [ -z "$Bat" ];then 
    bat="$icon4 $Adapt"
elif [ "$Bat" -gt "80" ];then 
    bat="$icon4 $Bat% $Ext"
elif [ "$Bat" -gt "60" ];then 
    bat="$icon3 $Bat% $Ext"
elif [ "$Bat" -gt "40" ];then 
    bat="$icon2 $Bat% $Ext"
elif [ "$Bat" -gt "10" ];then 
    bat="$icon1 $Bat% $Ext"
elif [ "$Bat" -lt "11" ];then
    bat="$icon0 $Bat% $Ext"
    if [ "$ischarging" -eq "0" ];then
    	exec notify-send -u critical -i notification-battery-low "Battery is low $Bat%" &
    fi
fi 

echo -e "$bat"
