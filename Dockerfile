FROM node:current-alpine

# Build deps
RUN apk --no-cache --virtual builddeps add git python py-pip make gcc g++ krb5-dev

COPY iquidus-entrypoint.sh /entrypoint.sh

RUN adduser -s /bin/ash -S  -u 1001 iquidus \
     && chmod +x /entrypoint.sh \
     && git clone https://github.com/iquidus/explorer.git app \
#     && sed -i 's/\/ext\/getlasttxsajax\/0/\/ext\/getlasttxsajax\/0.00000001/g' /app/views/index.pug \
     && cd app \
     && npm install --production 

#COPY logo.png /app/images/logo.png
#COPY logo.png /app/public/favicon.ico
COPY iquidus-settings.json /app/settings.json

RUN  chown -R iquidus /app

USER iquidus

ENTRYPOINT [ "/entrypoint.sh" ]

