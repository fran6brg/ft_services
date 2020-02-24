FROM telegraf:alpine

RUN apk -f update 
RUN apk -f add influxdb
RUN rm /etc/influxdb/influxdb.conf

COPY entrypoint.sh ./entrypoint2.sh
COPY influxdb.conf /etc/influxdb/influxdb.conf

EXPOSE 8086

CMD sh
CMD ["sh", "/entrypoint2.sh"]
