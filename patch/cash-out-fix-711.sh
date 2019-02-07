supervisorctl stop lamassu-server lamassu-admin-server
curl -#o cash-out-atomic.js https://raw.githubusercontent.com/lamassu/lamassu-server/6a661aa5c4512b63354fb8db01681fca4ab593fe/lib/cash-out/cash-out-atomic.js
supervisorctl start lamassu-server lamassu-admin-server
echo 'Patch applied.'
