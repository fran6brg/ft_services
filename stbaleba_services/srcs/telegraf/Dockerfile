FROM alpine:3.11.3

RUN apk update && apk add vim

RUN apk add openrc

RUN apk add musl

RUN apk add busybox

RUN apk add telegraf --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN rc-update add telegraf

RUN rc-status

RUN touch /run/openrc/softlevel

RUN rm etc/telegraf.conf

ADD telegraf.conf /etc/telegraf.conf 

ADD start.sh /start.sh

RUN chmod 755 start.sh

VOLUME ["/sys/fs/cgroup"]

ENTRYPOINT ["sh", "/start.sh"]
