#!/usr/bin/env bash

cd $(npm root -g)/lamassu-server/lib/
supervisorctl stop lamassu-server lamassu-admin-server
curl -#o ticker.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/ticker-polling/ticker-v711.js
curl -#o logger.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/ticker-polling/logger-v711.js
supervisorctl start lamassu-server lamassu-admin-server
echo 'Patch applied.'
