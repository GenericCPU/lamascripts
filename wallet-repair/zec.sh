#!/bin/bash
set -e

d=$(date -u "+%Y%m%d")

echo
echo 'Stopping Zcash...'
supervisorctl stop zcash &>/dev/null

echo 'Clearing the database, chainstate, and blocks...'
cd /mnt/blockchains/zcash
mkdir empty-$d
rsync -a --delete empty-$d/ database/
rsync -a --delete empty-$d/ chainstate/
rsync -a --delete empty-$d/ blocks/

echo 'Updating Zcash...'
curl -#o /tmp/zcash.tar.gz https://github.com/ZcashFoundation/zecwallet/releases/download/v0.7.6/linux-binaries-zecwallet-v0.7.6.tar.gz &>/dev/null
tar -xzf /tmp/zcash.tar.gz -C /tmp/
mv /usr/local/bin/zcashd /usr/local/bin/zcashd-old
mv /usr/local/bin/zcash-cli /usr/local/bin/zcash-cli-old
mv /usr/local/bin/zcash-tx /usr/local/bin/zcash-tx-old
mv /usr/local/bin/zcash-qt /usr/local/bin/zcash-qt-old
cp /tmp/zcash-0.7.6/bin/* /usr/local/bin/
rm -r /tmp/zcash-0.7.6
rm /tmp/zcash.tar.gz

echo 'Clearing Zcash logs...'
mv /var/log/supervisor/zcash.err.log /var/log/supervisor/zcash.err.log-$d
mv /var/log/supervisor/zcash.out.log /var/log/supervisor/zcash.out.log-$d

echo "Resetting Zcash's supervisor configuration..."
curl -#o /etc/supervisor/conf.d/zcash.conf https://raw.githubusercontent.com/lamassusupport/lamascripts/master/switches/reindex/zcash.conf-orig  &>/dev/null
supervisorctl reread &>/dev/null

echo 'Starting Zcash...'
supervisorctl start zcash &>/dev/null

echo 'Done!'
echo
