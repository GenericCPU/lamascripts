echo
echo "Patching the tickers..."
echo
cd $(npm root -g)/lamassu-server/lib/plugins/ticker/bitpay/
curl -#o bitpay.js https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/patch/ticker-bitpay/bitpay.js
echo
supervisorctl restart lamassu-server lamassu-admin-server
echo
echo "Tickers patched."
echo
