#!/bin/bash 
arc=$(uname -a)
processor=$(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l)
core=$(cat /proc/cpuinfo | grep 'processor' | wc -l)
fram=$(free -m | grep Mem: | awk '{ print $2 }') 
uram=$(free -m | grep Mem: | awk '{ print $3 }') 
pram=$(calc -d $fram/$uram | xargs -I {} calc -d 100/{} | cut -c 2-6) 
fdisk=$(df | grep sda2 | awk '{ print $2 }' | cut -c -3) 
udisk=$(df | grep sda2 | awk '{ print $3 }' | cut -c -3) 
pdisk=$(calc -d $fdisk/$udisk | xargs -I {} calc -d 100/{} | cut -c 2-6) 
cpul=$(top -n 1 | grep Cpu | awk '{ print $2 }') 
lb=$(who -b | awk '{ print $3 $4 }') 
lvmt=$(lsblk -o TYPE | grep "lvm" | wc -l) 
lvmu=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi) 
ctcp=$(cat /proc/net/tcp | wc -l) 
ulog=$(users | wc -w) 
ip=$(ifconfig wlo1 | grep -w inet | awk '{ print $2 }') 
mac=$(ifconfig wlo1 | grep -w ether | awk '{ print $2 }') 
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l) 
echo "#Architecture: $arc 
#CPU physical: $processor
#vCPU: $core 
#Memory Usage: $uram/${fram}MB ($pram%) 
#Disk Usage: $udisk/${fdisk}Gb ($pdisk%) 
#CPU load: $cpul 
#Last boot: $lb 
#LVM use: $lvmu 
#Connexions TCP : $ctcp ESTABLISHED 
#User log: $ulog 
#Network: IP $ip ($mac) 
#Sudo: $cmds cmd"
