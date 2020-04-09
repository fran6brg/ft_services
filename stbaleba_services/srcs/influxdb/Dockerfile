FROM alpine:3.11.3

RUN apk update && apk add vim

RUN apk add openrc

RUN apk add musl

RUN apk add busybox

RUN apk add influxdb

RUN rc-update add influxdb

RUN rc-status

RUN touch /run/openrc/softlevel

RUN rm etc/influxdb.conf

ADD influxdb.conf /etc/influxdb.conf 

ADD start.sh /start.sh

RUN chmod 755 start.sh

VOLUME ["/sys/fs/cgroup"]

ENTRYPOINT ["sh", "/start.sh"]
