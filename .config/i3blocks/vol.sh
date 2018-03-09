#!/bin/bash 
Vol=$(pamixer --get-volume "[ %]")
Mute=$(pamixer --get-mute "[-]")

if [ "$Mute" = true ];then 
    echo -e " Mute"
else
    if [ "$Vol" -gt "80" ];then
        echo -e " $Vol %"
    elif [ "$Vol" -gt "60" ];then
        echo -e " $Vol %"
    elif [ "$Vol" -gt "40" ];then
        echo -e " $Vol %"
    elif [ "$Vol" -gt "20" ];then
        echo -e " $Vol %"
    else 
        echo -e " $Vol %"
    fi 
fi 
 
unset Vol
unset Mute
