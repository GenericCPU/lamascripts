#!/usr/bin/env bash
set -e

echo "Finding exchange kraken.js file..."

cd $(dirname $(find / -name kraken.js | grep "/lamassu-server/" | grep exchange))
echo "Replacing with CAD-default Kraken trader..."
curl -#o kraken.js https://raw.githubusercontent.com/lamassusupport/lamascripts/master/switches/kraken/kraken-cad.js

echo "Finding common kraken.js file..."
echo "Adding CAD pairs to Kraken..."
cd $(dirname $(find / -name kraken.js |  grep "/lamassu-server/" | grep common))
curl -#o kraken.js https://raw.githubusercontent.com/lamassusupport/lamascripts/master/switches/kraken/kraken-common-cad.js

echo "Restarting lamassu-server..."
supervisorctl restart lamassu-server
echo "Change complete."
