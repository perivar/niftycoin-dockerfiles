#!/bin/bash

# use a json file that parses a json string from the environment
# note that settings.json needs to be a valid json file without comments etc.
CONFIG=/app/settings.json
node -p "try{JSON.stringify({...require('$CONFIG'), ...JSON.parse(process.env.EIQUIDUS_SETTINGS)}, null, 2)}catch(e){JSON.stringify({...require('$CONFIG')}, null, 2)}" > "${CONFIG}.tmp"
mv "${CONFIG}.tmp" "${CONFIG}"

# start cron
#/usr/sbin/crond -f &
#cron &
service cron start

cd /app
npm start
