#!/usr/bin/env bash
set -e

echo
echo "This patch is for servers running Bullish Bunene (v7.2). If you're running Ambient Antu (v7.1), refer to the knowledgebase article for the relevant patch."
echo
supervisorctl stop lamassu-server
curl -#o $(npm root -g)/lamassu-server/lib/notifier.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/notifications/notifier-711.js
curl -#o $(npm root -g)/lamassu-server/lib/poller.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/notifications/poller-721.js
supervisorctl start lamassu-server
echo
echo "Patch applied for Bullish Bunene (v7.2). All set."
echo
