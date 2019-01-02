#!/usr/bin/env bash

cd $(npm root -g)/lamassu-server/lib/

curl -#o ticker.js https://gist.githubusercontent.com/GenericCPU/615258827d5ed24fc26519ace9c52611/raw/974e550fd2e8b3782b6eb713ae0e7f55b3e90937/ticker.js

curl -#o logger.js https://gist.githubusercontent.com/GenericCPU/b766da9314f55aa1d853d835c2c437c8/raw/9e0dba187a58bb565e37e47d558c00ea3c2b43d2/logger.js

echo "Patch installed, restarting server"

supervisorctl restart lamassu-server
