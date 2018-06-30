#!/bin/bash
set -e

echo
echo 'Stopping Litecoin...'
supervisorctl stop litecoin

echo 'Clearing the database, chainstate, and blocks...'
cd /mnt/blockchains/litecoin
mkdir empty
rsync -a --delete empty/ database/
rsync -a --delete empty/ chainstate/
rsync -a --delete empty/ blocks/

echo 'Updating Litecoin...'
curl -#o /tmp/litecoin.tar.gz https://download.litecoin.org/litecoin-0.16.0/linux/litecoin-0.16.0-x86_64-linux-gnu.tar.gz
tar -xzf /tmp/litecoin.tar.gz -C /tmp/
mv /usr/local/bin/litecoind /usr/local/bin/litecoind-old
mv /usr/local/bin/litecoin-cli /usr/local/bin/litecoin-cli-old
mv /usr/local/bin/litecoin-tx /usr/local/bin/litecoin-tx-old
mv /usr/local/bin/litecoin-qt /usr/local/bin/litecoin-qt-old
cp /tmp/litecoin-0.16.0/bin/* /usr/local/bin/
rm -r /tmp/litecoin-0.16.0
rm /tmp/litecoin.tar.gz

echo "Resetting Litecoin's supervisor configuration..."
curl -#o /etc/supervisor/conf.d/litecoin.conf https://raw.githubusercontent.com/lamassu/lamassu-server/staging/lib/blockchain/litecoin.js
supervisorctl reread

echo 'Starting Litecoin...'
supervisorctl start litecoin

echo 'Done!'
echo
