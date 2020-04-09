FROM alpine:3.11.3

RUN apk update && apk add vim

RUN apk add openrc

RUN apk add musl

RUN apk add busybox

RUN apk add grafana --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN mkdir /usr/share/grafana/data

ADD grafana.db /usr/share/grafana/data/grafana.db

ADD start.sh /start.sh

RUN chmod 777 start.sh

ENTRYPOINT [ "sh", "/start.sh" ]
