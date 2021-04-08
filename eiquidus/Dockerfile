FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl sudo nano net-tools build-essential git-core python telnet iputils-ping libkrb5-dev cron && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash - && \
	apt-get install -y nodejs

RUN git clone https://github.com/team-exor/eiquidus.git app \
     && cd app \
     && npm install --production

COPY logo.png /app/public/img/logo.png
COPY logo.png /app/public/img/header_logo.png
COPY logo.png /app/public/favicon.ico
COPY eiquidus-settings.json /app/settings.json

# Copy cronjob file to the cron.d directory
COPY cronjob /etc/cron.d/eiquidus-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/eiquidus-cron

# Apply cron job
RUN crontab /etc/cron.d/eiquidus-cron
 
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

COPY eiquidus-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
 
USER root
EXPOSE 3001

ENTRYPOINT [ "./entrypoint.sh" ]
