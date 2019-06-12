#!/usr/bin/env bash
set -e

echo "Finding lib folder..."
echo "Replacing plugins.js..."
curl -#o $(npm root -g)/lamassu-server/lib/plugins.js https://raw.githubusercontent.com/naconner/lamascripts/master/switch/tx-expiration/plugins.js 
echo "Replacing route-helper.js..."
curl -#o $(npm root -g)/lamassu-server/lib/route-helper.js https://raw.githubusercontent.com/naconner/lamascripts/master/switch/tx-expiration/route-helper.js 
echo "Restarting lamassu-server..."
supervisorctl restart lamassu-server
echo "Change complete."
