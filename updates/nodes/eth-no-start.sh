#!/bin/bash
set -e

echo 'Updating Ethereum. This may take a minute.'
supervisorctl stop ethereum
echo 'Downloading...'
curl -#o /tmp/ethereum.tar.gz https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.8.14-316fc7ec.tar.gz
tar -xzf /tmp/ethereum.tar.gz -C /tmp/
echo 'Updating...'
mv /usr/local/bin/geth /usr/local/bin/geth-old
cp /tmp/geth-linux-amd64-1.8.14-316fc7ec/geth /usr/local/bin/geth
rm -r /tmp/geth-linux-amd64-1.8.14-316fc7ec
rm /tmp/ethereum.tar.gz
echo 'Ethereum is updated.'
