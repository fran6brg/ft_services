FROM telegraf:alpine

RUN apk -f update

COPY telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 10255

CMD ["sh", "/entrypoint.sh", "-"]
