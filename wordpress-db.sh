#!/bin/bash

# DB side (mysql server)
publicip=$2
ipaddr=`ifconfig eth0 | grep inet | awk -F " " '{print $2}' | awk -F ":" '{print $2}' | head -1`
echo "IP Address of the machine is $ipaddr"
echo "Sleeping for 10 minutes" >> /home/$1/log.txt
sleep 600
#sudo apt-get update
#sudo apt-get install -y mysql-server
#sudo mysql_install_db
