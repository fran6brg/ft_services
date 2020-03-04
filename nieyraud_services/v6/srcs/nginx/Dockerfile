FROM alpine:3.11.3

# NGINX CONFIG

RUN apk update && apk upgrade
RUN apk add nginx
RUN apk add openssl \
	&& openssl req -x509 -nodes -days 365 \
	-subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" \
	-addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt
RUN mkdir /run/nginx && touch /run/nginx/nginx.pid && mkdir -p /usr/share/nginx/html

COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.nginx-debian.html /usr/share/nginx/html/index.nginx-debian.html
COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

EXPOSE 80 443 22

ENTRYPOINT ["sh", "/entrypoint.sh"]