#!/bin/sh
echo "Running container-startup.sh..."
echo "Starting nginx..."
nginx
echo "Running tail -f /dev/null to keep container running..."
tail -f /dev/null
# Shouldn't get here because of tail -f above
echo "container-startup.sh exiting..."
