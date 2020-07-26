FROM alpine:3.11.3

RUN apk -f upgrade && apk -f update
RUN apk -f add wget
RUN apk add openrc musl busybox
RUN apk add telegraf --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN touch /var/run/utmp

COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN mkdir -p /run/secrets/kubernetes.io/serviceaccount
RUN touch /run/secrets/kubernetes.io/serviceaccount/token
COPY entrypoint.sh ./entrypoint.sh
EXPOSE 35000

CMD ["sh", "/entrypoint.sh"]
