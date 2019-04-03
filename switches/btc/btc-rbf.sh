#!/usr/bin/env bash
set -e

echo "Updating Bitcoin's conf file..."
curl -#o /etc/supervisor/conf.d/bitcoin.conf https://raw.githubusercontent.com/naconner/lamascripts/master/switches/btc/bitcoin.conf
echo "Restarting Bitcoin..."
supervisorctl reread bitcoin
supervisorctl update bitcoin
supervisorctl restart bitcoin
echo "Bitcoin update to use RBF complete."
