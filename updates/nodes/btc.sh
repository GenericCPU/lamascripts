#!/bin/bash
set -e

echo 'Updating Bitcoin Core. This may take a minute.'
supervisorctl stop bitcoin
echo 'Downloading...'
curl -#o /tmp/bitcoin.tar.gz https://bitcoin.org/bin/bitcoin-core-0.16.3/bitcoin-0.16.3-x86_64-linux-gnu.tar.gz
tar -xzf /tmp/bitcoin.tar.gz -C /tmp/
echo 'Updating...'
mv /usr/local/bin/bitcoind /usr/local/bin/bitcoind-old
mv /usr/local/bin/bitcoin-cli /usr/local/bin/bitcoin-cli-old
mv /usr/local/bin/bitcoin-tx /usr/local/bin/bitcoind-tx-old
mv /usr/local/bin/bitcoin-qt /usr/local/bin/bitcoind-qt-old
cp /tmp/bitcoin-0.16.3/bin/* /usr/local/bin/
rm -r /tmp/bitcoin-0.16.3
rm /tmp/bitcoin.tar.gz
supervisorctl start bitcoin
echo 'Bitcoin Core is updated.'
