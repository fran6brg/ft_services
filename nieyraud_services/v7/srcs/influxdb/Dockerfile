FROM alpine:3.11.3

RUN apk -f upgrade && apk -f update
RUN apk -f add wget
RUN apk add openrc musl busybox
RUN apk add influxdb --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community


COPY entrypoint.sh ./entrypoint.sh
COPY influxdb.conf /etc/influxdb.conf

ENTRYPOINT ["sh", "entrypoint.sh"]