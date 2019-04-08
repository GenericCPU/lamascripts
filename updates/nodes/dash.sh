#!/bin/bash
set -e

echo 'Updating Dash Core. This may take a minute.'
supervisorctl stop dash
echo 'Downloading...'
curl -#Lo /tmp/dash.tar.gz https://github.com/dashpay/dash/releases/download/v0.13.3.0/dashcore-0.13.3.0-x86_64-linux-gnu.tar.gz
tar -xzf /tmp/dash.tar.gz -C /tmp/
echo 'Updating...'
mv /usr/local/bin/dashd /usr/local/bin/dashd-old
mv /usr/local/bin/dash-cli /usr/local/bin/dash-cli-old
mv /usr/local/bin/dash-tx /usr/local/bin/dash-tx-old
mv /usr/local/bin/dash-qt /usr/local/bin/dash-qt-old
cp /tmp/dashcore-0.13.3/bin/* /usr/local/bin/
rm -r /tmp/dashcore-0.13.3
rm /tmp/dash.tar.gz
supervisorctl start dash
echo 'Dash Core is updated.'
