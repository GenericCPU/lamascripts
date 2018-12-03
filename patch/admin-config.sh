#!/usr/bin/env bash

supervisorctl stop lamassu-server lamassu-admin-server
curl -#o /usr/lib/node_modules/lamassu-server/lib/admin/admin-server.js https://raw.githubusercontent.com/lidio601/lamassu-server/02083941f1e7a8bbb6c8d1c5928870a2560e0264/lib/admin/admin-server.js
curl -#o /usr/lib/node_modules/lamassu-server/lib/admin/config.js https://raw.githubusercontent.com/lidio601/lamassu-server/02083941f1e7a8bbb6c8d1c5928870a2560e0264/lib/admin/config.js
curl -#o /usr/lib/node_modules/lamassu-server/lib/config-validate.js https://raw.githubusercontent.com/lidio601/lamassu-server/02083941f1e7a8bbb6c8d1c5928870a2560e0264/lib/config-validate.js
curl -#o /usr/lib/node_modules/lamassu-server/lib/migrate-options.js https://raw.githubusercontent.com/lidio601/lamassu-server/02083941f1e7a8bbb6c8d1c5928870a2560e0264/lib/migrate-options.js
supervisorctl start lamassu-server lamassu-admin-server
