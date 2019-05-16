#!/usr/bin/env bash
set -e

echo "Finding kraken.js..."
cd $(dirname $(find / -name kraken.js |   grep "/lamassu-server/" | grep exchange))
echo "Replacing with USD-default Kraken trader..."
curl -#o kraken.js https://raw.githubusercontent.com/lamassusupport/lamascripts/master/switches/kraken/kraken-usd.js
echo "Restarting lamassu-server..."
supervisorctl restart lamassu-server
echo "Change complete."
