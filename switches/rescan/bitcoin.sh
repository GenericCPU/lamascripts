#!/bin/bash
set -e

echo "This should take a couple seconds..."

curl -#o /etc/supervisor/conf.d/bitcoin.conf https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/switches/rescan/bitcoin.conf
supervisorctl update bitcoin
curl -#o /etc/supervisor/conf.d/bitcoin.conf https://raw.githubusercontent.com/LamassuSupport/lamascripts/master/switches/reindex/bitcoin.conf-orig

echo "Done!"
