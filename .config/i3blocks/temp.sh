#!/bin/bash 

temp=$(sensors | grep "Core 0:" | awk '{print $3}' | tr -d "+" )

echo -e " $temp"
