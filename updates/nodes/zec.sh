#!/bin/bash
set -e

echo 'Updating Zcash. This may take a minute.'
supervisorctl stop zcash
echo 'Downloading...'
curl -#o /tmp/zcash.tar.gz https://z.cash/downloads/zcash-1.1.0-linux64.tar.gz
tar -xzf /tmp/zcash.tar.gz -C /tmp/
echo 'Updating...'
mv /usr/local/bin/zcashd /usr/local/bin/zcashd-old
mv /usr/local/bin/zcash-cli /usr/local/bin/zcash-cli-old
mv /usr/local/bin/zcash-tx /usr/local/bin/zcash-tx-old
mv /usr/local/bin/zcash-fetch-params /usr/local/bin/zcash-fetch-params-old
cp /tmp/zcash-1.1.0/bin/* /usr/local/bin/
rm -r /tmp/zcash-1.1.0
rm /tmp/zcash.tar.gz
curl -#o /etc/supervisor/conf.d/zcash.conf https://raw.githubusercontent.com/naconner/lamascripts/master/updates/nodes/zcash.conf
supervisorctl start zcash
echo 'Zcash is updated.'
