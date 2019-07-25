#!/bin/bash
set -e

echo 'Updating Bitcoin Cash. This may take a minute.'
supervisorctl stop bitcoincash
echo 'Downloading...'
curl -#o /tmp/bitcoincash.tar.gz https://download.bitcoinabc.org/0.19.10/linux/bitcoin-abc-0.19.10-x86_64-linux-gnu.tar.gz
tar -xzf /tmp/bitcoincash.tar.gz -C /tmp/
echo 'Updating...'
mv /usr/local/bin/bitcoincashd /usr/local/bin/bitcoincashd-old
mv /usr/local/bin/bitcoincash-cli /usr/local/bin/bitcoin-cli-old
cp /tmp/bitcoin-abc-0.19.10/bin/bitcoind /usr/local/bin/bitcoincashd
cp /tmp/bitcoin-abc-0.19.10/bin/bitcoin-cli /usr/local/bin/bitcoincash-cli
rm -r /tmp/bitcoin-abc-0.19.10
rm /tmp/bitcoincash.tar.gz
supervisorctl start bitcoincash
echo 'Bitcoin Cash is updated.'
