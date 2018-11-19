#!/usr/bin/env bash

supervisorctl stop lamassu-server lamassu-admin-server
su - postgres -c "pg_dump lamassu > /tmp/lamassu-database.bak"
su - postgres -c "psql \"lamassu\" -Atc \"DELETE FROM machine_pings WHERE created < NOW() - INTERVAL '1 hour'\""
su - postgres -c "psql \"lamassu\" -Atc \"DELETE FROM machine_events WHERE created < NOW() - INTERVAL '1 hour'\""
su - postgres -c "psql \"lamassu\" -Atc \"DELETE FROM server_events WHERE created < NOW() - INTERVAL '1 hour'\""
supervisorctl start lamassu-server lamassu-admin-server
