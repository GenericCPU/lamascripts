#!/bin/bash
set -e

d=$(date -u "+%Y%m%d")

echo
echo 'Stopping Bitcoin...'
supervisorctl stop bitcoin &>/dev/null

echo 'Clearing the database, chainstate, and blocks...'
cd /mnt/blockchains/bitcoin
mkdir empty-$d
rsync -a --delete empty-$d/ database/
rsync -a --delete empty-$d/ chainstate/
rsync -a --delete empty-$d/ blocks/

echo 'Updating Bitcoin...'
curl -#o /tmp/bitcoin.tar.gz https://bitcoincore.org/bin/bitcoin-core-0.16.3/bitcoin-0.16.3-x86_64-linux-gnu.tar.gz &>/dev/null
tar -xzf /tmp/bitcoin.tar.gz -C /tmp/
mv /usr/local/bin/bitcoind /usr/local/bin/bitcoind-old
mv /usr/local/bin/bitcoin-cli /usr/local/bin/bitcoin-cli-old
mv /usr/local/bin/bitcoin-tx /usr/local/bin/bitcoin-tx-old
mv /usr/local/bin/bitcoin-qt /usr/local/bin/bitcoin-qt-old
cp /tmp/bitcoin-0.16.3/bin/* /usr/local/bin/
rm -r /tmp/bitcoin-0.16.3
rm /tmp/bitcoin.tar.gz

echo 'Clearing Bitcoin logs...'
mv /var/log/supervisor/bitcoin.err.log /var/log/supervisor/bitcoin.err.log-$d
mv /var/log/supervisor/bitcoin.out.log /var/log/supervisor/bitcoin.out.log-$d

echo "Resetting Bitcoin's supervisor configuration..."
curl -#o /etc/supervisor/conf.d/bitcoin.conf https://raw.githubusercontent.com/naconner/lamascripts/master/switches/reindex/bitcoin.conf-orig  &>/dev/null
supervisorctl reread &>/dev/null

echo 'Starting Bitcoin...'
supervisorctl start bitcoin &>/dev/null

echo 'Done!'
echo
