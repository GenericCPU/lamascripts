#!/bin/bash
set -e

d=$(date -u "+%Y%m%d")

echo
echo 'Stopping Dash...'
supervisorctl stop dash &>/dev/null

echo 'Clearing the database, chainstate, and blocks...'
cd /mnt/blockchains/dash
mkdir empty-$d
rsync -a --delete empty-$d/ database/
rsync -a --delete empty-$d/ chainstate/
rsync -a --delete empty-$d/ blocks/

echo 'Updating Dash...'
curl -#Lo /tmp/dash.tar.gz https://github.com/dashpay/dash/releases/download/v0.13.3.0/dashcore-0.13.3.0-x86_64-linux-gnu.tar.gz  &>/dev/null
tar -xzf /tmp/dash.tar.gz -C /tmp/
mv /usr/local/bin/dashd /usr/local/bin/dashd-old
mv /usr/local/bin/dash-cli /usr/local/bin/dash-cli-old
mv /usr/local/bin/dash-tx /usr/local/bin/dash-tx-old
mv /usr/local/bin/dash-qt /usr/local/bin/dash-qt-old
cp /tmp/dashcore-0.13.3/bin/* /usr/local/bin/
rm -r /tmp/dashcore-0.13.3
rm /tmp/dash.tar.gz

echo 'Clearing Dash logs...'
mv /var/log/supervisor/dash.err.log /var/log/supervisor/dash.err.log-$d
mv /var/log/supervisor/dash.out.log /var/log/supervisor/dash.out.log-$d

echo "Setting Dash's supervisor configuration..."
curl -#o /etc/supervisor/conf.d/dash.conf https://raw.githubusercontent.com/naconner/lamascripts/master/switches/reindex/dash-orig.conf  &>/dev/null
supervisorctl reread &>/dev/null

echo 'Starting Dash...'
supervisorctl start dash &>/dev/null

echo 'Done!'
echo
