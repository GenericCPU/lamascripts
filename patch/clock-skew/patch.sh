#!/usr/bin/env bash
set -e

echo
echo "Patching routes.js..."
echo
cd $(npm root -g)/lamassu-server/lib/
curl -#o routes.js https://raw.githubusercontent.com/lamassu/lamassu-server/e875806ee9bf291cad5dc00fa7db74c6e9317cea/lib/routes.js
echo
supervisorctl restart lamassu-server lamassu-admin-server
echo
echo "Routes.js patched."
echo
