#!/bin/bash
set -e

echo 'Updating Ethereum and setting to fast mode. This may take a minute.'
supervisorctl stop ethereum
echo 'Downloading...'
curl -#o /tmp/ethereum.tar.gz https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.8.11-dea1ce05.tar.gz
tar -xzf /tmp/ethereum.tar.gz -C /tmp/
echo 'Updating...'
mv /usr/local/bin/geth /usr/local/bin/geth-old
cp /tmp/geth-linux-amd64-1.8.11-dea1ce05/geth /usr/local/bin/geth
rm -r /tmp/geth-linux-amd64-1.8.11-dea1ce05
rm /tmp/ethereum.tar.gz
curl -#o /usr/lib/node_modules/lamassu-server/lib/blockchain/ethereum.js https://raw.githubusercontent.com/lamassu/lamassu-server/v5/lib/blockchain/ethereum.js
curl -#o /etc/supervisor/conf.d/ethereum.conf https://raw.githubusercontent.com/naconner/lamascripts/master/switches/fast/ethereum.conf
echo 'Complete. Rebooting the server. You may log back in after a minute.'
shutdown -r now
