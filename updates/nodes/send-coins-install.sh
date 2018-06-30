#!/bin/bash
set -e

cd /usr/lib/node_modules/lamassu-server/
echo 'Installing new dependencies...'
npm install ethereumjs-util@5.2.0 &>/dev/null
npm install inquirer@5.2.0 &>/dev/null
echo 'Pulling down changes...'
curl -#o lib/plugins/wallet/geth/geth.js https://raw.githubusercontent.com/lamassu/lamassu-server/d14256702eb080592d1f414c0a98a980cee3fb89/lib/plugins/wallet/geth/geth.js &>/dev/null
curl -#o lib/wallet.js https://raw.githubusercontent.com/lamassu/lamassu-server/d14256702eb080592d1f414c0a98a980cee3fb89/lib/wallet.js &>/dev/null
curl -#o bin/lamassu-send-coins https://raw.githubusercontent.com/lamassu/lamassu-server/d14256702eb080592d1f414c0a98a980cee3fb89/bin/lamassu-send-coins &>/dev/null
chmod 755 bin/lamassu-send-coins
ln -s /usr/lib/node_modules/lamassu-server/bin/lamassu-send-coins /usr/bin/lamassu-send-coins
echo 'Restarting lamassu-server...'
supervisorctl restart lamassu-server &>/dev/null
echo 'Done.'
echo
echo 'Use may use lamassu-send-coins to manually create transactions.'
echo 'Note this is a beta script from an upcoming version in testing. Use with great care when sending coins. No warranty express or implied.'
