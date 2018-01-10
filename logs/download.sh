#!/usr/bin/env bash
set -e

curl -#o /usr/local/bin/cash-in-log https://raw.githubusercontent.com/naconner/lamascripts/master/logs/cash-in-log
curl -#o /usr/local/bin/cash-out-log https://raw.githubusercontent.com/naconner/lamascripts/master/logs/cash-out-log
curl -#o /usr/local/bin/bills-log https://raw.githubusercontent.com/naconner/lamascripts/master/logs/bills-log
curl -#o /usr/local/bin/cash-in-unencrypted https://raw.githubusercontent.com/naconner/lamascripts/master/logs/cash-in-unencrypted
curl -#o /usr/local/bin/cash-out-unencrypted https://raw.githubusercontent.com/naconner/lamascripts/master/logs/cash-out-unencrypted
curl -#o /usr/local/bin/bills-log-unencrypted https://raw.githubusercontent.com/naconner/lamascripts/master/logs/bills-log-unencrypted
curl -#o /usr/local/bin/send-server-log https://raw.githubusercontent.com/naconner/lamascripts/master/logs/send-server-log
chmod 755 /usr/local/bin/cash-in-log
chmod 755 /usr/local/bin/cash-out-log
chmod 755 /usr/local/bin/bills-log
chmod 755 /usr/local/bin/cash-in-unencrypted
chmod 755 /usr/local/bin/cash-out-unencrypted
chmod 755 /usr/local/bin/bills-log-unencrypted
chmod 755 /usr/local/bin/send-server-log
echo 'Done! You may now use the following commands, followed by an email address:\r\n- cash-in-log\r\n- cash-out-log\r\n- bills-log\r\n- cash-in-unencrypted\r\n- cash-out-unencrypted'
