#!/bin/bash
set -e

d=$(date -u "+%Y%m%d")

echo
echo 'Stopping Litecoin...'
supervisorctl stop litecoin &>/dev/null

echo 'Clearing the database, chainstate, and blocks...'
cd /mnt/blockchains/litecoin
mkdir empty-$d
rsync -a --delete empty-$d/ database/
rsync -a --delete empty-$d/ chainstate/
rsync -a --delete empty-$d/ blocks/

echo 'Updating Litecoin...'
curl -#o /tmp/litecoin.tar.gz https://download.litecoin.org/litecoin-0.16.0/linux/litecoin-0.16.0-x86_64-linux-gnu.tar.gz  &>/dev/null
tar -xzf /tmp/litecoin.tar.gz -C /tmp/
mv /usr/local/bin/litecoind /usr/local/bin/litecoind-old
mv /usr/local/bin/litecoin-cli /usr/local/bin/litecoin-cli-old
mv /usr/local/bin/litecoin-tx /usr/local/bin/litecoin-tx-old
mv /usr/local/bin/litecoin-qt /usr/local/bin/litecoin-qt-old
cp /tmp/litecoin-0.16.0/bin/* /usr/local/bin/
rm -r /tmp/litecoin-0.16.0
rm /tmp/litecoin.tar.gz

echo 'Clearing Litecoin logs...'
mv /var/log/supervisor/litecoin.err.log /var/log/supervisor/litecoin.err.log-$d
mv /var/log/supervisor/litecoin.out.log /var/log/supervisor/litecoin.out.log-$d

echo "Resetting Litecoin's supervisor configuration..."
curl -#o /etc/supervisor/conf.d/litecoin.conf https://raw.githubusercontent.com/naconner/lamascripts/master/switches/reindex/litecoin.conf-orig  &>/dev/null
supervisorctl reread &>/dev/null

echo 'Starting Litecoin...'
supervisorctl start litecoin &>/dev/null

echo 'Done!'
echo
