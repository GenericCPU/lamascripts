#!/bin/bash
set -e

echo 'Updating Litecoin Core. This may take a minute.'
supervisorctl stop litecoin
echo 'Downloading...'
curl -#o /tmp/litecoin.tar.gz https://download.litecoin.org/litecoin-0.16.3/linux/litecoin-0.16.3-x86_64-linux-gnu.tar.gz
tar -xzf /tmp/litecoin.tar.gz -C /tmp/
echo 'Updating...'
mv /usr/local/bin/litecoind /usr/local/bin/litecoind-old
mv /usr/local/bin/litecoin-cli /usr/local/bin/litecoin-cli-old
mv /usr/local/bin/litecoin-tx /usr/local/bin/litecoin-tx-old
mv /usr/local/bin/litecoin-qt /usr/local/bin/litecoin-qt-old
cp /tmp/litecoin-0.16.3/bin/* /usr/local/bin/
rm -r /tmp/litecoin-0.16.3
rm /tmp/litecoin.tar.gz
supervisorctl start litecoin
echo 'Litecoin Core is updated.'
