FROM alpine:3.11.3

# NGINX CONFIG

RUN apk update && apk upgrade
RUN apk add nginx
RUN apk add php7-fpm php7-mbstring php7-session php7-mysqli php7-gettext \
	php7-pdo php7-zip php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc \
	php7-pdo_mysql php7-pdo_sqlite php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib \
	php7-curl php7-ctype php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom

RUN apk add openssl \
	&& openssl req -x509 -nodes -days 365 \
	-subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" \
	-addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt
	
RUN mkdir /run/nginx && touch /run/nginx/nginx.pid && mkdir -p /usr/share/nginx/html
RUN mkdir /run/php
RUN adduser nginx nginx
RUN chown -R nginx:nginx /etc/php7
RUN chown -R nginx:nginx /etc/nginx

COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.nginx-debian.html /index.nginx-debian.html
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY php.ini /etc/php7/php.ini
COPY entrypoint.sh /entrypoint.sh

EXPOSE 80 443 22

ENTRYPOINT ["sh", "/entrypoint.sh"]