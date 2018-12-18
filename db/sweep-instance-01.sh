#!/usr/bin/env bash
set -e

export LOG_FILE=/tmp/db-update.$(date +"%Y%m%d").log

su - postgres -c "psql \"lamassu\" -Atc \"UPDATE "cash_out_txs" SET ("status", "dispense", "notified", "redeem", "dispense_confirmed", "confirmed_at", "published_at") = ('confirmed', true, true, true, true, now(), now()) WHERE id = '6535638b-8ac1-4666-96dd-858fb5c69327'\"" >> ${LOG_FILE} 2>&1

cat ${LOG_FILE}
