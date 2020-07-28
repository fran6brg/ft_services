FROM alpine:3.11.3

RUN apk update && apk upgrade --available
RUN apk add vsftpd

RUN apk add openssl \
	&& openssl req -x509 -nodes -days 365 \
	-subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" \
	-addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 \
	-keyout /etc/ssl/private/ftps-selfsigned.key \
	-out /etc/ssl/certs/ftps-selfsigned.crt

RUN mkdir ftps
RUN echo root >> /etc/vsftpd.userlist

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY entrypoint.sh ./entrypoint.sh

CMD ["sh", "/entrypoint.sh"]
