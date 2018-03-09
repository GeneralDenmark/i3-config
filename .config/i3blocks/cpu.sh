#!/bin/bash 

Cpu=$(mpstat -u | grep "all" | awk '{print $3"%"}')

echo -e " $Cpu"
