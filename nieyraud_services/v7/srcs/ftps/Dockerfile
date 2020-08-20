FROM alpine:3.11.3

RUN apk update && apk upgrade --available
RUN apk add vsftpd lftp

RUN apk add openrc musl busybox

RUN apk add openssl \
	&& openssl req -x509 -nodes -days 365 \
	-subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" \
	-addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 \
	-keyout /etc/ssl/private/ftps-selfsigned.key \
	-out /etc/ssl/certs/ftps-selfsigned.crt

RUN adduser admin --disabled-password && echo admin | passwd -d admin
RUN mkdir -p /admin/ftps
RUN chown -P admin:admin /admin/ftps
RUN echo "Ca marche!" >> /admin/ftps/anon.txt
RUN chmod 777 admin/ftps
RUN echo admin >> /etc/vsftpd.userlist
RUN mkdir -p /var/log/ && touch /var/log/vsftpd.log

RUN rc-update add vsftpd && rc-status

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY entrypoint.sh ./entrypoint.sh

EXPOSE 21 20

CMD ["sh", "/entrypoint.sh"]
