#!/usr/bin/env bash
set -e

echo "Finding exchange kraken.js file..."

echo "Replacing with CAD-default Kraken trader..."
curl -#o $(npm root -g)/lamassu-server/lib/plugins/exchange/kraken/kraken.js https://raw.githubusercontent.com/lamassusupport/lamascripts/master/switches/kraken/kraken-cad.js

echo "Finding common kraken.js file..."
echo "Adding CAD pairs to Kraken..."
curl -#o $(npm root -g)/lamassu-server/lib/plugins/common/kraken.js https://raw.githubusercontent.com/lamassusupport/lamascripts/master/switches/kraken/kraken-common-cad.js

echo "Restarting lamassu-server..."
supervisorctl restart lamassu-server
echo "Change complete."
