#!/usr/bin/env bash
set -e

curl -#o $(npm root -g)/lamassu-server/lib/ticker.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/logger/ticker.js
curl -#o $(npm root -g)/lamassu-server/lib/logger.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/logger/logger.js
echo "Patched."
