#!/usr/bin/env bash

supervisorctl stop lamassu-server
curl -#o /usr/local/lib/node_modules/lamassu-server/lib/coin-utils.js https://raw.githubusercontent.com/lamassu/lamassu-server/release/lib/coin-utils.js
curl -#o /usr/local/lib/node_modules/lamassu-server/lib/plugins/common/kraken.js https://raw.githubusercontent.com/lamassu/lamassu-server/release/lib/plugins/common/kraken.js
curl -#o /usr/local/lib/node_modules/lamassu-server/lib/plugins/exchange/bitstamp/bitstamp.js https://raw.githubusercontent.com/lamassu/lamassu-server/release/lib/plugins/exchange/bitstamp/bitstamp.js
curl -#o /usr/local/lib/node_modules/lamassu-server/lib/plugins/exchange/kraken/kraken.js https://raw.githubusercontent.com/lamassu/lamassu-server/release/lib/plugins/exchange/kraken/kraken.js
supervisorctl start lamassu-server
