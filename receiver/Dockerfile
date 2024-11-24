# Use Ubuntu as the base image
FROM ubuntu:latest

# Update the package list and install Netcat
RUN apt-get update && apt-get install -y netcat-openbsd

# Create a directory to store received files
WORKDIR /data

# Start Netcat on container startup
CMD ["sh", "-c", "nc -k -l -p 12345 > /dev/null"]

