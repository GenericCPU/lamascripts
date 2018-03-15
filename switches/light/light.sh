#!/usr/bin/env bash
set -e

supervisorctl stop ethereum
curl -#o /usr/lib/node_modules/lamassu-server/lib/blockchain/ethereum.js https://raw.githubusercontent.com/naconner/lamascripts/master/switches/light/ethereum.js
curl -#o /etc/supervisor/conf.d/ethereum.conf https://raw.githubusercontent.com/naconner/lamascripts/master/switches/light/ethereum.conf
cd /mnt/blockchains/ethereum/geth/
rm chaindata/*
shutdown -r now
