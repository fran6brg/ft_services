FROM alpine:3.11.3

RUN apk -f upgrade && apk -f update
RUN apk add vsftpd openssl
RUN openssl req -nodes -x509 -newkey  rsa:2048 -days 365 -subj "/C=FR/ST=France/L=Paris/O=42/OU=127.0.0.1" -keyout /etc/ssl/private/ssl_key.key -out /etc/ssl/certs/ssl_cert.pem

COPY entrypoint.sh /entrypoint.sh

EXPOSE 21

CMD ["sh", "/entrypoint.sh"]
