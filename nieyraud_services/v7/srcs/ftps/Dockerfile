FROM alpine:3.11.3

RUN apk update
RUN apk add musl busybox
RUN apk add bash pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
RUN mkdir -p /home/admin /var/lib/ftp/ /usr/local/etc/ /etc/pure-ftpd/auth/
RUN touch /usr/local/etc/pureftpd.passwd /etc/pureftpd.passwd
RUN adduser admin --disabled-password
RUN chown admin /home/admin

COPY pure-ftpd.pem /etc/ssl/private/
COPY entrypoint.sh /entrypoint.sh

EXPOSE 21 20
CMD ["sh", "/entrypoint.sh"]
