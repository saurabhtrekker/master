#!/bin/bash

FILE=/root/log.txt

echo "Starting..." > $FILE
#sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get update >> $FILE
sudo apt-get install -y apache2 >> $FILE
sudo apt-get install -y wordpress >> $FILE
echo "Done..." >> $FILE
