#!/bin/bash
set -e

echo 'Setting Ethereum to light mode. This may take up to 10 minutes.'
supervisorctl stop ethereum
curl -#o /usr/lib/node_modules/lamassu-server/lib/blockchain/ethereum.js https://raw.githubusercontent.com/naconner/lamascripts/master/switches/light/ethereum.js
curl -#o /etc/supervisor/conf.d/ethereum.conf https://raw.githubusercontent.com/naconner/lamascripts/master/switches/light/ethereum.conf
cd /mnt/blockchains/ethereum/geth/
echo 'Deleting old chaindata.'
find chaindata/* -type f -delete
echo 'Complete. Rebooting the server. You may log back in after a minute.'
shutdown -r now
