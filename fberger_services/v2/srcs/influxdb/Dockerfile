FROM influxdb:alpine

RUN rm /etc/influxdb/influxdb.conf
COPY influxdb.conf /etc/influxdb/influxdb.conf

COPY entrypoint.sh ./entrypoint2.sh

EXPOSE 8086

CMD ["sh", "/entrypoint2.sh"]
