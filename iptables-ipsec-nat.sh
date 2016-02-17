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
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 50022 -j DNAT --to $1.5.4:22
 
 
# for IPSEC
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 500 -j DNAT --to $1.1.4
sudo iptables -t nat -A PREROUTING -i eth0 -p udp --dport 500 -j DNAT --to $1.1.4
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 4500 -j DNAT --to $1.1.4
sudo iptables -t nat -A PREROUTING -i eth0 -p udp --dport 4500 -j DNAT --to $1.1.4
 
sudo iptables -t nat -A PREROUTING -i eth0 -p esp -j DNAT --to $1.1.4
 
sudo iptables -t nat -A PREROUTING -i eth0 -p ah -j DNAT --to $1.1.4
 
# MASQUERADE all other outdoing traffic from NAT
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
 
# Install iptables-persistent package which makes current iptables rules
# persistent across reboots.
sudo iptables-save -c > /etc/iptables.rules
printf "#!/bin/sh \niptables-restore < /etc/iptables.rules\nexit 0\n" > /etc/network/if-pre-up.d/iptablesload
printf "#!/bin/sh\niptables-save -c > /etc/iptables.rules\nif [ -f /etc/iptables.downrules ]; then\n   iptables-restore < /etc/iptables.downrules\nfi\nexit 0\n" > /etc/network/if-post-dow
n.d/iptablessave
sudo chmod +x /etc/network/if-post-down.d/iptablessave
sudo chmod +x /etc/network/if-pre-up.d/iptablesload
