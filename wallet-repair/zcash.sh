#!/bin/bash
set -e

d=$(date -u "+%Y%m%d%H%M%S")

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
curl -#o /tmp/zcash.tar.gz https://z.cash/downloads/zcash-2.0.6-linux64.tar.gz &>/dev/null
tar -xzf /tmp/zcash.tar.gz -C /tmp/
mv /usr/local/bin/zcashd /usr/local/bin/zcashd-old || true
mv /usr/local/bin/zcash-cli /usr/local/bin/zcash-cli-old || true
mv /usr/local/bin/zcash-tx /usr/local/bin/zcash-tx-old || true
mv /usr/local/bin/zcash-fetch-params /usr/local/bin/zcash-fetch-params-old || true
cp /tmp/zcash-2.0.6/bin/* /usr/local/bin/
rm -r /tmp/zcash-2.0.6
rm /tmp/zcash.tar.gz

echo 'Clearing Zcash logs...'
mv /var/log/supervisor/zcash.err.log /var/log/supervisor/zcash.err.log-$d
mv /var/log/supervisor/zcash.out.log /var/log/supervisor/zcash.out.log-$d

echo "Resetting Zcash's supervisor configuration..."
curl -#o /etc/supervisor/conf.d/zcash.conf https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/updates/nodes/zcash.conf &>/dev/null
supervisorctl reread &>/dev/null

echo "Updating dependencies..."
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test &>/dev/null
sudo apt-get update &>/dev/null
sudo apt-get install libstdc++6 &>/dev/null 


echo "Downloading Sapling parameters..."
zcash-fetch-params &>/dev/null
supervisorctl update zcash &>/dev/null
echo 'Starting Zcash...'
supervisorctl start zcash &>/dev/null

echo 'Done!'
