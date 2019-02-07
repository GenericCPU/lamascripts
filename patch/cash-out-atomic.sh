supervisorctl stop lamassu-server
curl -#o /usr/lib/node_modules/lamassu-server/lib/cash-out/cash-out-atomic.js https://raw.githubusercontent.com/naconner/lamascripts/master/backports/exchange/cash-out-atomic.js
supervisorctl start lamassu-server
echo 'Patch applied.'
