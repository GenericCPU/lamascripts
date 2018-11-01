#!/usr/bin/env bash
set -e

decho "Finding bitstamp.js..."
cd $(dirname $(find / -name bitstamp.js | grep -v "lamassu-server-old" | grep exchange))
decho "Replacing with USD-default Bitstamp trader..."
curl -#o bitstamp.js https://raw.githubusercontent.com/naconner/lamascripts/master/switches/bitstamp/bitstamp-usd.js
decho "Restarting lamassu-server..."
supervisorctl restart lamassu-server
decho "Change complete."
