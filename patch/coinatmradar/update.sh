#!/usr/bin/env bash
set -e
bold=$(tput bold)

echo
echo "Applying patch for Coin ATM Radar support..."
supervisorctl stop lamassu-server lamassu-admin-server &> /dev/null
curl -#o $(npm root -g)/lamassu-server/lib/plugins.js https://raw.githubusercontent.com/lamassu/lamassu-server/206cb902af4a2fd252aedcf5ec2cf4cffab4ee6a/lib/plugins.js &> /dev/null
curl -#o /usr/local/bin/lamassu-coinatmradar https://raw.githubusercontent.com/lamassu/lamassu-server/d9befeedf55026d1aec9673358831dfe4af78bbd/bin/lamassu-coinatmradar &> /dev/null
chmod 755 /usr/local/bin/lamassu-coinatmradar &> /dev/null
supervisorctl start lamassu-server lamassu-admin-server &> /dev/null
echo
echo "Patch applied. Please now run ${bold}lamassu-coinatmradar${normal} and follow the rest of the article."
echo
