
#!/usr/bin/env bash
set -e

echo
echo "Patching the tickers..."
echo
cd $(npm root -g)/lamassu-server/lib/
curl -#o bitpay.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/ticker-bignumber/bitpay.js
curl -#o bitstamp.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/ticker-bignumber/bitstamp.js
curl -#o kraken.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/ticker-bignumber/kraken.js
echo
supervisorctl restart lamassu-server lamassu-admin-server
echo
echo "Patch applied."
