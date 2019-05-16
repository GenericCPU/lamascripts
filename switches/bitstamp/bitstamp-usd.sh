#!/usr/bin/env bash
set -e

echo "Finding bitstamp.js..."
cd $(dirname $(find / -name bitstamp.js |  grep "/lamassu-server/" | grep exchange))
echo "Replacing with USD-default Bitstamp trader..."
curl -#o bitstamp.js https://raw.githubusercontent.com/lamassusupport/lamascripts/master/switches/bitstamp/bitstamp-usd.js
echo "Restarting lamassu-server..."
supervisorctl restart lamassu-server
echo "Change complete."
