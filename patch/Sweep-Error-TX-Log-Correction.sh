#!/usr/bin/env bash

#Error message template for incorrect input or invalid transaction ID
ERRORMSG="Please supply a valid Transaction ID from your admin's transaction
panel"

#If input is null, exit and print error message.
if test -z "$1"; then
  echo $ERRORMSG
  exit 1
fi

#Query the ID to see if it's valid, if invalid an error should be logged.
TX=`su - postgres -c "psql \"lamassu\" -Atc \"select * from cash_out_txs where id = '$1'\""`
TXDATA=`tail -1 /var/log/postgresql/postgresql-9.5-main.log`

#If TXID doesn't exist in the database the psql logs should reference that; if so, exit and print an error message.
if [[ $TXDATA == *"$1"* ]]; then
  echo $ERRORMSG
  exit 1
fi

#Stop the server
supervisorctl stop lamassu-server lamassu-admin-server

#Update the TX to trigger sweeping
su - postgres -c "psql \"lamassu\" -Atc \"UPDATE "cash_out_txs" SET ("status","dispense", "notified", "redeem", "dispense_confirmed", "confirmed_at","published_at") = ('confirmed', true, true, true, true, now(), now()) WHERE id = '$1'\""

#Start the server
supervisorctl start lamassu-server lamassu-admin-server
echo 'Patch applied.'
