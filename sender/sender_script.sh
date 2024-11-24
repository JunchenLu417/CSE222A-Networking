#!/bin/bash

# Variables
RECEIVER_NETWORK="192.168.2.0/24"  # Receiver network
ROUTER_IP="192.168.1.4"            # Router IP in sender network
RECEIVER_PORT="12345"              # Port for file transfer

# Determine the receiver IP based on the congestion control algorithm
if [ "${TCP_CONGESTION_CONTROL}" = "bbr" ]; then
    RECEIVER_IP="192.168.2.3"
else
    RECEIVER_IP="192.168.2.2"
fi

# Add static route for the receiver network via the router
ip route add ${RECEIVER_NETWORK} via ${ROUTER_IP}

# Check and load BBR module if required
if [ "${TCP_CONGESTION_CONTROL}" = "bbr" ]; then
    if ! sysctl net.ipv4.tcp_available_congestion_control | grep -qw bbr; then
        modprobe tcp_bbr
    fi
    sysctl -w net.core.default_qdisc=fq
fi

# Set the TCP congestion control algorithm
sysctl -w net.ipv4.tcp_congestion_control=${TCP_CONGESTION_CONTROL}

# Start the TCP connection
dd if=/dev/zero bs=1G count=10 | nc ${RECEIVER_IP} ${RECEIVER_PORT}
