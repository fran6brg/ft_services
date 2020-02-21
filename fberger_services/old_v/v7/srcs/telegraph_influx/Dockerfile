FROM telegraf:1.13.2

RUN apk -f update
RUN apk -f add influx telegraf

COPY entrypoint.sh /entrypoint.sh
COPY telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 8086

CMD ["sh", "/entrypoint.sh"]