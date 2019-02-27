#!/usr/bin/env bash
set -e

echo
read -p "This patch is for servers running Ambient Antu (v7.1). Are you running this version? [y/N] " response
echo
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    supervisorctl stop lamassu-server
    curl -#o $(npm root -g)/lamassu-server/lib/notifier.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/notifications/notifier-711.js
    curl -#o $(npm root -g)/lamassu-server/lib/poller.js https://raw.githubusercontent.com/naconner/lamascripts/master/patch/notifications/poller-711.js
    supervisorctl start lamassu-server
    echo
    echo "Patch applied. All set."
    echo
else
    echo "Please reference the support article for the patch for Bullish Bunene (v7.2)."
    echo
fi
