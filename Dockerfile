FROM node:current-alpine

# Build deps
RUN apk --no-cache --virtual builddeps add git python py-pip make gcc g++ krb5-dev

COPY iquidus-entrypoint.sh /entrypoint.sh

RUN adduser -s /bin/ash -S  -u 1001 iquidus \
     && chmod +x /entrypoint.sh \
     && git clone https://github.com/iquidus/explorer.git app \
     && sed -i 's/\/ext\/getlasttxsajax\/0/\/ext\/getlasttxsajax\/0.00000001/g' /app/views/index.pug \
     && sed -i 's/diffString = parseFloat(json.data\[0\].difficulty).toFixed(2);/diffString = parseFloat(json.data\[0\].difficulty).toFixed(4);/g' /app/views/layout.pug \
#     && sed -i 's/db.create_peer/if (geo.country_name.length > 1 \&\& geo.country_code.length > 1) db.create_peer/' /app/scripts/peers.js \
     && cd app \
     && npm install --production 

COPY logo.png /app/public/images/logo.png
COPY logo.png /app/public/favicon.ico
COPY iquidus-settings.json /app/settings.json
# fix an error where peers are constantly dropped because of local docker ip without country code etc
COPY iquidus-peers.js /app/scripts/peers.js
# add CORS support
COPY iquidus-app.js /app/app.js

RUN  chown -R iquidus /app

USER iquidus

ENTRYPOINT [ "/entrypoint.sh" ]

