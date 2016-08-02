#!/bin/bash

# Webserver side (mysql client)
publicip=$2
ipaddr=`ifconfig eth0 | grep inet | awk -F " " '{print $2}' | awk -F ":" '{print $2}' | head -1`
echo "IP Address of the machine is $ipaddr"
sudo echo "Arguments to script are: ($1) and ($2) and PrivateIP Address: $ipaddr" >> /home/$1/log.txt
echo "Starting..."  >> /home/$1/log.txt
sleep 600
#sudo apt-get update && sudo apt-get -y upgrade
#sudo apt-get update
#sudo apt-get install -y apache2
#sudo apt-get install -y wordpress
#sudo ln -s /usr/share/wordpress /var/www/html/wordpress
#sudo gzip -d /usr/share/doc/wordpress/examples/setup-mysql.gz
#sudo bash /usr/share/doc/wordpress/examples/setup-mysql -n demo $ipadrr
#sudo mv /etc/wordpress/config-$ipaddr.php /etc/wordpress/config-$publicip.php
echo "Done..." >> /home/$1/log.txt
