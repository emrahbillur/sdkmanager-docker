#!/bin/sh
# Usage: docker-entrypoint.sh [cmd [arg0 [arg1 ...]]]

echo ">>>>> Entering NVIDIA SDKManager development container..."

# Exit on failure
set -e

echo "Setting up container for user:$user($uid) group:$group($gid)..."

# Make new user and group
#groupadd -f -g "$gid" "$group"
#useradd -u "$uid" -g "$gid" -m "$user"

# Start here
useradd nvidia && echo "nvidia:nvidia" |chpasswd && adduser nvidia sudo &&\
    mkdir -p /home/nvidia/Downloads/nvidia && chown -R nvidia:nvidia /home/nvidia

# Run cmd as new user
USER nvidia
WORKDIR /home/nvidia
echo "<<<<< Leaving NVIDIA SDKManager development container..."
