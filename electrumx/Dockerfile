FROM python:3.9-alpine3.13
# based on work by lukechilds, https://github.com/lukechilds/docker-electrumx/
# based on work by peerchemist, https://github.com/peercoin/electrumx-docker/

ENV _VERSION=1.16.0

RUN wget -q -O electrumx.tar.gz https://github.com/spesmilo/electrumx/archive/${_VERSION}.tar.gz
RUN tar -xzf electrumx.tar.gz

WORKDIR /electrumx-${_VERSION}

# these are the minimum packages needed for electrumx and openssl (to build the self signed ssl certificates)
RUN apk add --no-cache build-base openssl && \
    apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community leveldb-dev && \
    apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing rocksdb-dev && \
    pip install aiohttp pylru plyvel websockets python-rocksdb

# in order to run the sanic based rpcd deamon, we need to add several development packages
RUN apk add --no-cache python3 \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install -U pip setuptools ez_setup \
    && rm -r /root/.cache/* \
    && apk add --no-cache gcc autoconf python3-dev musl-dev make openssl-dev \
    && pip3 install -U sanic sanic_cors aiorpcX

# append our coin
COPY ./coins.py /data/coins.py
RUN cat /data/coins.py >> ./electrumx/lib/coins.py

# install electrumx and clean up afterwards
RUN python setup.py install && \
    apk del gcc autoconf python3-dev musl-dev make openssl-dev && \
    rm -rf /var/cache/apk/* /var/tmp/* /root/.cache/* && \
    apk del build-base && \
    rm -rf /tmp/*

COPY ./bin/* /usr/local/bin/
RUN chmod a+x /usr/local/bin/*

VOLUME ["/data"]
ENV HOME /data
ENV ALLOW_ROOT 1
ENV DB_DIRECTORY /data
ENV SERVICES=tcp://:50001,ssl://:50002,wss://:50004,rpc://0.0.0.0:8000
ENV SSL_CERTFILE ${DB_DIRECTORY}/electrumx.crt
ENV SSL_KEYFILE ${DB_DIRECTORY}/electrumx.key
ENV BANNER_FILE ${DB_DIRECTORY}/banner_file.txt
ENV HOST ""
WORKDIR /data

EXPOSE 50001 50002 50004 50005 8000

CMD ["init"]
#ENTRYPOINT ["tail"]
#CMD ["-f","/dev/null"]

