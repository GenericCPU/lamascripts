#!/bin/bash
set -e

echo 'Updating Ethereum. This may take a minute.'
supervisorctl stop ethereum
echo 'Downloading...'
curl -#o /tmp/ethereum.tar.gz https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.8.11-dea1ce05.tar.gz
tar -xzf /tmp/ethereum.tar.gz -C /tmp/
echo 'Updating...'
mv /usr/local/bin/geth /usr/local/bin/geth-old
cp /tmp/geth-linux-amd64-1.8.11-dea1ce05/geth /usr/local/bin/geth
rm -r /tmp/geth-linux-amd64-1.8.11-dea1ce05
rm /tmp/ethereum.tar.gz
echo 'Ethereum is updated.'
