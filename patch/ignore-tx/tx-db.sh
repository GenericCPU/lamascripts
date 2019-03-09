#!/usr/bin/env bash
set -e

echo
echo "Patching server..."
echo
supervisorctl stop lamassu-server lamassu-admin-server
curl -#o $(npm root -g)/lamassu-server/lib/error.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/ignore-tx/error.js
curl -#o $(npm root -g)/lamassu-server/lib/routes.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/ignore-tx/routes.js
curl -#o $(npm root -g)/lamassu-server/lib/tx.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/ignore-tx/tx.js
supervisorctl start lamassu-server lamassu-admin-server
echo
echo "Patch applied."
echo
