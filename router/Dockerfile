# Use Ubuntu as the base image
FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y iproute2 iptables

# Copy the setup script into the container
COPY setup.sh /usr/local/bin/setup.sh

# Make the script executable
RUN chmod +x /usr/local/bin/setup.sh

# Run the setup script and keep the container alive
CMD ["/bin/sh", "-c", "/usr/local/bin/setup.sh && tail -f /dev/null"]

