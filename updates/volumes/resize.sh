#!/usr/bin/env bash
set -e

VOLUME=$(ls /dev/disk/by-id/scsi-0DO_Volume_* | grep -m1 -oP '(?<=by-id/).+$')
supervisorctl stop all
sleep 3s
resize2fs /dev/disk/by-id/$VOLUME
sleep 5s
supervisorctl start all
echo
echo "Done! Volume resized and services restarted."
