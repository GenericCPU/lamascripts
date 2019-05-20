#!/usr/bin/env bash
set -e

echo "Finding bitstamp.js..."
echo "Replacing with USD-default Bitstamp trader..."
curl -#o $(npm root -g)/lamassu-server/lib/plugins/exchange/bitstamp/bitstamp.js https://raw.githubusercontent.com/lamassusupport/lamascripts/master/switches/bitstamp/bitstamp-usd.js
echo "Restarting lamassu-server..."
supervisorctl restart lamassu-server
echo "Change complete."
