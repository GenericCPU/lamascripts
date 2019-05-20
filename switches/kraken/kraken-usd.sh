#!/usr/bin/env bash
set -e

echo "Finding kraken.js..."
echo "Replacing with USD-default Kraken trader..."
curl -#o $(npm root -g)/lamassu-server/lib/plugins/exchange/kraken/kraken.js https://raw.githubusercontent.com/lamassusupport/lamascripts/master/switches/kraken/kraken-usd.js
echo "Restarting lamassu-server..."
supervisorctl restart lamassu-server
echo "Change complete."
