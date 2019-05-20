#!/usr/bin/env bash
set -e

supervisorctl stop lamassu-server lamassu-admin-server
curl -#o $(npm root -g)/lamassu-server/lib/ticker.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/logger/ticker.js
curl -#o $(npm root -g)/lamassu-server/lib/logger.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/logger/logger.js
echo "Patched."
supervisorctl start lamassu-server lamassu-admin-server
