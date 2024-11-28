#!/bin/bash

# Receiver IP and Port
RECEIVER_PORT="12345"
if [ "${TCP_CONGESTION_CONTROL}" = "bbr" ]; then
    RECEIVER_IP="192.168.2.3"
else
    RECEIVER_IP="192.168.2.2"
fi

# Log file for congestion window data
LOG_FILE="/cwnd_log.csv"

# Start logging
while true; do
    TIMESTAMP=$(date +%s)
    CWND=$(ss -i dst $RECEIVER_IP | grep -oP "cwnd:\K[0-9]+")
    if [ -n "$CWND" ]; then
        echo "$TIMESTAMP,$CWND" >> $LOG_FILE
    fi
done
