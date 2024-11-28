#!/bin/sh
# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

while ! ip link show eth1 >/dev/null 2>&1; do
    sleep 1
done

# Configure iptables rules
iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Configure tc (traffic control) to add latency and packet loss
# Add latency and packet loss for packets forwarded from eth0 to eth1
tc qdisc add dev eth0 root handle 1: netem delay 100ms loss 0.005%

# Add latency and packet loss for packets forwarded from eth1 to eth0
tc qdisc add dev eth1 root handle 1: netem delay 100ms loss 0.005%
