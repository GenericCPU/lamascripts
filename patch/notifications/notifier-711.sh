#!/usr/bin/env bash
set -e

echo
echo "This patch is for servers running Ambient Antu (v7.1). If you're running Bullish Bunene (v7.2), refer to the knowledgebase article for the relevant patch."
echo
supervisorctl stop lamassu-server
curl -#o $(npm root -g)/lamassu-server/lib/notifier.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/notifications/notifier-711.js
curl -#o $(npm root -g)/lamassu-server/lib/poller.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/notifications/poller-711.js
supervisorctl start lamassu-server
echo
echo "Patch applied for Ambient Antu (v7.1). All set."
echo
