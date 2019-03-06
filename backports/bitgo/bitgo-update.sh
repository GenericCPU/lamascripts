#!/usr/bin/env bash
set -e

echo
echo "This patch is for servers running Ambient Antu (v7.1) or Bullish Bunene (v7.2)."
echo
echo "However, if you deploy to v7.1 and subsequently update to v7.2, you'll need to deploy this patch again as its changes are overwritten during the upgrade."
echo
echo "Applying patch. This may take ~30 seconds..."
supervisorctl stop lamassu-server lamassu-admin-server &> /dev/null
cd $(npm root -g)/lamassu-server/
npm install bitgo@4.47.0 bchaddrjs@0.3.0 --unsafe-perm --silent --no-progress &> /dev/null
curl -#o $(npm root -g)/lamassu-server/lib/plugins/wallet/bitgo/bitgo.js https://raw.githubusercontent.com/naconner/lamascripts/master/backports/bitgo/bitgo.js &> /dev/null
curl -#o $(npm root -g)/lamassu-server/lib/admin/config.js https://raw.githubusercontent.com/naconner/lamascripts/master/backports/bitgo/config.js &> /dev/null
curl -#o $(npm root -g)/lamassu-server/schemas/bitgo.json https://raw.githubusercontent.com/naconner/lamascripts/master/backports/bitgo/bitgo.json &> /dev/null
supervisorctl start lamassu-server lamassu-admin-server &> /dev/null
echo
echo "Patch complete! Please follow the article on configuring BitGo to set up your wallets."
echo
