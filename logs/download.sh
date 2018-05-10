#!/usr/bin/env bash
set -e

curl -#o /usr/local/bin/cash-in-log https://raw.githubusercontent.com/naconner/lamascripts/master/logs/cash-in-log 2>/dev/null
curl -#o /usr/local/bin/cash-out-log https://raw.githubusercontent.com/naconner/lamascripts/master/logs/cash-out-log 2>/dev/null
curl -#o /usr/local/bin/bills-log https://raw.githubusercontent.com/naconner/lamascripts/master/logs/bills-log 2>/dev/null
curl -#o /usr/local/bin/cash-in-unencrypted https://raw.githubusercontent.com/naconner/lamascripts/master/logs/cash-in-unencrypted 2>/dev/null
curl -#o /usr/local/bin/cash-out-unencrypted https://raw.githubusercontent.com/naconner/lamascripts/master/logs/cash-out-unencrypted 2>/dev/null
curl -#o /usr/local/bin/bills-log-unencrypted https://raw.githubusercontent.com/naconner/lamascripts/master/logs/bills-log-unencrypted 2>/dev/null
curl -#o /usr/local/bin/send-server-log https://raw.githubusercontent.com/naconner/lamascripts/master/logs/send-server-log 2>/dev/null
curl -#o /usr/local/bin/export-cash-in https://raw.githubusercontent.com/naconner/lamascripts/master/logs/export-cash-in 2>/dev/null
curl -#o /usr/local/bin/export-cash-out https://raw.githubusercontent.com/naconner/lamascripts/master/logs/export-cash-out 2>/dev/null
curl -#o /usr/local/bin/export-bills https://raw.githubusercontent.com/naconner/lamascripts/master/logs/export-bills 2>/dev/null
curl -#o /usr/local/bin/cash-out-actions https://raw.githubusercontent.com/naconner/lamascripts/master/logs/cash-out-actions 2>/dev/null
curl -#o /usr/local/bin/out-actions-unencrypted https://raw.githubusercontent.com/naconner/lamascripts/master/logs/out-actions-unencrypted 2>/dev/null
curl -#o /usr/local/bin/export-out-actions https://raw.githubusercontent.com/naconner/lamascripts/master/logs/export-out-actions 2>/dev/null
curl -#o /usr/local/bin/customers-log https://raw.githubusercontent.com/naconner/lamascripts/master/logs/customers-log 2>/dev/null
curl -#o /usr/local/bin/export-customers https://raw.githubusercontent.com/naconner/lamascripts/master/logs/export-customers 2>/dev/null
chmod 755 /usr/local/bin/cash-in-log
chmod 755 /usr/local/bin/cash-out-log
chmod 755 /usr/local/bin/bills-log
chmod 755 /usr/local/bin/cash-in-unencrypted
chmod 755 /usr/local/bin/cash-out-unencrypted
chmod 755 /usr/local/bin/bills-log-unencrypted
chmod 755 /usr/local/bin/send-server-log
chmod 755 /usr/local/bin/export-cash-in
chmod 755 /usr/local/bin/export-cash-out
chmod 755 /usr/local/bin/export-bills
chmod 755 /usr/local/bin/cash-out-actions
chmod 755 /usr/local/bin/out-actions-unencrypted
chmod 755 /usr/local/bin/export-out-actions
chmod 755 /usr/local/bin/customers-log
chmod 755 /usr/local/bin/export-customers
echo
echo 'Done! You may now use the following commands, followed by an email address:'
echo
echo 'cash-in-log'
echo 'cash-out-log'
echo 'bills-log'
echo 'customers-log'
echo 'cash-in-unencrypted'
echo 'cash-out-unencrypted'
echo 'bills-log-unencrypted'
echo 'send-server-log'
echo
echo 'The first three encrypt the logs prior to sending them, thus should first import a PGP key onto your server. Otherwise, use the unencrypted commands.'
echo
