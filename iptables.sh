#!/bin/bash

sudo iptables --flush 
sudo iptables --table nat --flush
sudo iptables --delete-chain
sudo iptables --table nat --delete-chain
sudo iptables -F
sudo iptables -X

# enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# For login to NAT machine using ssh -p 50022
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 50022 -j DNAT --to 10.5.5.4:22

# Redirect all UDP/TCP traffic to web-server
sudo iptables -t nat -A PREROUTING -d 10.5.5.4 -p tcp -j DNAT --to-destination 10.5.3.5
sudo iptables -t nat -A PREROUTING -d 10.5.5.4 -p udp -j DNAT --to-destination 10.5.3.5

# Web/DB to Internet : Change source address to NAT's device IP of subnet Web and DB
sudo iptables -t nat -A POSTROUTING -s 10.5.3.0/24 -o eth0 -p tcp -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -s 10.5.4.0/24 -o eth0 -p tcp -j MASQUERADE

# SNAT for outbound & inbound traffic. TODO SNAT only for outbound traffic
sudo iptables -A FORWARD -i eth0 -p tcp --dport 80 -d 10.5.5.4 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -d 10.5.3.5 -p tcp -j SNAT --to-source 10.5.5.4
sudo iptables -t nat -A POSTROUTING -d 10.5.4.5 -p tcp -j SNAT --to-source 10.5.5.4

# Install iptables-persistent package which makes current iptables rules
# persistent across reboots.
export DEBIAN_FRONTEND=noninteractive
sudo apt-get --assume-yes install iptables-persistent
