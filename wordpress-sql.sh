#!/bin/bash

ipaddr=`ifconfig eth0 | grep inet | awk -F " " '{print $2}' | awk -F ":" '{print $2}' | head -1`
echo "IP Address of the machine is $ipaddr"
echo "Starting..." 
#sudo apt-get update && sudo apt-get -y upgrade
#sudo apt-get update
#sudo apt-get install -y apache2
#sudo apt-get install -y wordpress
echo "Done..."
