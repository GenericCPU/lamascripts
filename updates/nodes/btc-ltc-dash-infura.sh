#!/bin/bash
set -e

# Disable geth
echo "Disabling Geth..."
if [ -f /etc/supervisor/conf.d/ethereum.conf ]; then
    mv /etc/supervisor/conf.d/ethereum.conf /root/ethereum.conf
fi
supervisorctl reread
supervisorctl update
echo "Geth disabled."
echo

# Update bitcoin
echo "Updating Bitcoin Core. This may take a minute..."
curl -#o $(npm root -g)/lamassu-server/lib/plugins/wallet/bitcoind/bitcoind.js https://raw.githubusercontent.com/lamassu/lamassu-server/defiant-dingirma/lib/plugins/wallet/bitcoind/bitcoind.js
supervisorctl stop bitcoin
curl -#o /tmp/bitcoin.tar.gz https://bitcoin.org/bin/bitcoin-core-0.18.1/bitcoin-0.18.1-x86_64-linux-gnu.tar.gz
tar -xzf /tmp/bitcoin.tar.gz -C /tmp/
mv /usr/local/bin/bitcoind /usr/local/bin/bitcoind-old
mv /usr/local/bin/bitcoin-cli /usr/local/bin/bitcoin-cli-old
mv /usr/local/bin/bitcoin-tx /usr/local/bin/bitcoind-tx-old
mv /usr/local/bin/bitcoin-qt /usr/local/bin/bitcoind-qt-old
cp /tmp/bitcoin-0.18.1/bin/* /usr/local/bin/
rm -r /tmp/bitcoin-0.18.1
rm /tmp/bitcoin.tar.gz
supervisorctl start bitcoin
echo "Bitcoin Core is updated."
echo

# Update dash
echo "Updating Dash Core. This may take a minute..."
supervisorctl stop dash
curl -#Lo /tmp/dash.tar.gz https://github.com/dashpay/dash/releases/download/v0.14.0.3/dashcore-0.14.0.3-x86_64-linux-gnu.tar.gz
tar -xzf /tmp/dash.tar.gz -C /tmp/
mv /usr/local/bin/dashd /usr/local/bin/dashd-old
mv /usr/local/bin/dash-cli /usr/local/bin/dash-cli-old
mv /usr/local/bin/dash-tx /usr/local/bin/dash-tx-old
mv /usr/local/bin/dash-qt /usr/local/bin/dash-qt-old
cp /tmp/dashcore-0.14.0/bin/* /usr/local/bin/
rm -r /tmp/dashcore-0.14.0
rm /tmp/dash.tar.gz
supervisorctl start dash
echo "Dash Core is updated."
echo 

# Update litecoin
echo "Updating Litecoin Core. This may take a minute..."
curl -#o $(npm root -g)/lamassu-server/lib/plugins/wallet/litecoind/litecoind.js https://raw.githubusercontent.com/lamassu/lamassu-server/defiant-dingirma/lib/plugins/wallet/litecoind/litecoind.js
supervisorctl stop litecoin
curl -#o /tmp/litecoin.tar.gz https://download.litecoin.org/litecoin-0.17.1/linux/litecoin-0.17.1-x86_64-linux-gnu.tar.gz
tar -xzf /tmp/litecoin.tar.gz -C /tmp/
mv /usr/local/bin/litecoind /usr/local/bin/litecoind-old
mv /usr/local/bin/litecoin-cli /usr/local/bin/litecoin-cli-old
mv /usr/local/bin/litecoin-tx /usr/local/bin/litecoin-tx-old
mv /usr/local/bin/litecoin-qt /usr/local/bin/litecoin-qt-old
cp /tmp/litecoin-0.17.1/bin/* /usr/local/bin/
rm -r /tmp/litecoin-0.17.1
rm /tmp/litecoin.tar.gz
supervisorctl start litecoin
echo "Litecoin Core is updated."
echo

echo "Patching the tickers..."
curl -#o $(npm root -g)/lamassu-server/lib/plugins/ticker/bitpay/bitpay.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/ticker-bignumber/bitpay.js
curl -#o $(npm root -g)/lamassu-server/lib/plugins/ticker/bitstamp/bitstamp.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/ticker-bignumber/bitstamp.js
curl -#o $(npm root -g)/lamassu-server/lib/plugins/ticker/kraken/kraken.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/ticker-bignumber/kraken.js
supervisorctl restart lamassu-server lamassu-admin-server
echo "Tickers updated."
echo
