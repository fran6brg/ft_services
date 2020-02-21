FROM telegraf:alpine

RUN apk -f update 
RUN apk -f add influxdb

COPY entrypoint.sh ./entrypoint2.sh

EXPOSE 8086

CMD sh
CMD ["sh", "/entrypoint2.sh"]
