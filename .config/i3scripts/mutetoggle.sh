#!/usr/bin/env bash

Muted="$(pamixer --get-mute)"

if ${Muted} ; then
    pamixer -u
else
	pamixer -m
fi
exec pkill -SIGRTMIN+3 i3blocks
unset Muted