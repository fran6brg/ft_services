FROM alpine:3.11.3


RUN apk -f upgrade && apk -f update
RUN apk -f add wget
RUN apk add openrc musl busybox
RUN apk add grafana --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing


COPY grafana.db /usr/share/grafana/data/grafana.db
COPY entrypoint.sh ./entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["sh", "/entrypoint.sh"]