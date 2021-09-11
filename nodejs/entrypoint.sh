#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Print Node.js Version
VER=$(node -v)

printf "|------------------------------------------------|"
printf "| "
printf "| Thank you for choosing Elytron Discord Hosting!"
printf "| You are currently using ${VER}, to change this please open a ticket."
printf "| To install packages, please be sure they are set in your package.json file!"
printf "| "
printf "|------------------------------------------------|"

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e if [ -f /home/container/package.json ]; then /usr/local/bin/npm install; fi; /usr/local/bin/node /home/container/${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
