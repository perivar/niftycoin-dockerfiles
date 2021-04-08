FROM node:current-alpine

# Build deps
RUN apk --no-cache --virtual builddeps add git python py-pip make gcc g++ krb5-dev

COPY eiquidus-entrypoint.sh /entrypoint.sh

RUN adduser -s /bin/ash -S  -u 1001 eiquidus \
     && chmod +x /entrypoint.sh \
     && git clone https://github.com/team-exor/eiquidus.git app \
     && cd app \
     && npm install --production 

COPY logo.png /app/public/img/logo.png
COPY logo.png /app/public/img/header_logo.png
COPY logo.png /app/public/favicon.ico
COPY eiquidus-settings.json /app/settings.json

RUN  chown -R eiquidus /app

USER eiquidus

ENTRYPOINT [ "/entrypoint.sh" ]
