FROM telegraf:alpine

RUN apk -f update

RUN touch /var/run/utmp

COPY telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 35000

CMD ["sh", "/entrypoint.sh", "-"]
