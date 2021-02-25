#!/bin/ash

# use a json file that parses a json string from the environment
# note that settings.json needs to be a valid json file without comments etc.
CONFIG=/app/settings.json
node -p "try{JSON.stringify({...require('$CONFIG'), ...JSON.parse(process.env.IQUIDUS_SETTINGS)}, null, 2)}catch(e){JSON.stringify({...require('$CONFIG')}, null, 2)}" > "${CONFIG}.tmp"
mv "${CONFIG}.tmp" "${CONFIG}"

run_update() {
 sleep 120
 while true ; do
   node --stack-size=10000 ./scripts/sync.js index update 
   sleep 60
 done
}
run_market() {
 sleep 130
 while true ; do
   node --stack-size=10000 ./scripts/sync.js market
   sleep 120
 done
}
run_peers() {
 sleep 140
 while true ; do
   node --stack-size=10000 ./scripts/sync.js index update 
   sleep 300
 done
}

cd /app
run_update &
run_market &
run_peers &
npm start
