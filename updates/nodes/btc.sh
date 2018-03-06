#!/bin/bash
set -e

supervisorctl stop bitcoin
curl -#o bitcoin.tar.gz https://bitcoin.org/bin/bitcoin-core-0.16.0/bitcoin-0.16.0-x86_64-linux-gnu.tar.gz
tar -xvzf bitcoin.tar.gz
mv /usr/local/bin/bitcoind /usr/local/bin/bitcoind-old
mv /usr/local/bin/bitcoin-cli /usr/local/bin/bitcoin-cli-old
mv /usr/local/bin/bitcoin-tx /usr/local/bin/bitcoind-tx-old
mv /usr/local/bin/bitcoin-qt /usr/local/bin/bitcoind-qt-old
cp bitcoin-0.16.0/bin/* /usr/local/bin/
supervisorctl start bitcoin
echo 'Bitcoin Core is updated.'
