#!/bin/bash
set -e

echo 'Updating Bitcoin Cash. This may take a minute.'
supervisorctl stop bitcoincash
echo 'Downloading...'
curl -#o /tmp/bitcoincash.tar.gz https://download.bitcoinabc.org/0.20.0/linux/bitcoin-abc-0.20.0-x86_64-linux-gnu.tar.gz
tar -xzf /tmp/bitcoincash.tar.gz -C /tmp/
echo 'Updating...'
mv /usr/local/bin/bitcoincashd /usr/local/bin/bitcoincashd-old
mv /usr/local/bin/bitcoincash-cli /usr/local/bin/bitcoin-cli-old
cp /tmp/bitcoin-abc-0.20.0/bin/bitcoind /usr/local/bin/bitcoincashd
cp /tmp/bitcoin-abc-0.20.0/bin/bitcoin-cli /usr/local/bin/bitcoincash-cli
rm -r /tmp/bitcoin-abc-0.20.0
rm /tmp/bitcoincash.tar.gz
sed -i 's/\<connections\>/maxconnections/g' /mnt/blockchains/bitcoincash/bitcoincash.conf
supervisorctl start bitcoincash
echo 'Bitcoin Cash is updated.'
