FROM node:10
RUN apt-get update
RUN apt-get install -y sudo git nano curl

WORKDIR /usr/src/app

RUN git clone https://github.com/niftycoin-project/node-open-mining-portal .
RUN npm update

ENV REDIS_HOST		redis
ENV REDIS_PORT		6379
ENV ADMIN_PASSWORD	password
ENV STRATUM_HOST	stratum.domainname.xyz
ENV IFRAME_BASEURL      https://pool.domainname.xyz

ADD setup.sh /usr/src/app/
ADD run.sh /usr/src/app/

VOLUME /usr/src/app/coins
VOLUME /usr/src/app/pool_configs

COPY coins/niftycoin.json /usr/src/app/coins/
COPY pool_configs/niftycoin.json /usr/src/app/pool_configs/

EXPOSE 8888
EXPOSE 4000
EXPOSE 4008
EXPOSE 4032
EXPOSE 4256

CMD [ "sh", "run.sh" ]
