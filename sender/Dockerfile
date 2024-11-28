# Use Ubuntu as the base image
FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y iproute2 iputils-ping netcat-openbsd

# Copy the script to configure the sender and start the data transfer
COPY sender_script.sh /usr/local/bin/sender_script.sh
COPY monitor_cwnd.sh /usr/local/bin/monitor_cwnd.sh

# Make the script executable
RUN chmod +x /usr/local/bin/sender_script.sh /usr/local/bin/monitor_cwnd.sh

# Set a default congestion control algorithm (can be overridden at runtime)
ENV TCP_CONGESTION_CONTROL=cubic

# Set the script as the entrypoint
CMD ["/bin/bash", "-c", "/usr/local/bin/monitor_cwnd.sh & /usr/local/bin/sender_script.sh"]
