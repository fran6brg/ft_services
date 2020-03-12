FROM alpine:3.11.3

# CONFIG
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

# # SSH | https://www.dontpanicblog.co.uk/2018/11/30/ssh-into-a-docker-container/
# RUN apk add openrc openssh-server
# # RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser
# RUN addgroup sshgroup
# # cut -d: -f1 /etc/group | sort | grep ssh
# # RUN adduser -S sshuser -G sshgroup 
# RUN adduser -Ds /bin/sh -g sshgroup sshuser
# # cut -d: -f1 /etc/passwd | sort | grep ssh
# RUN echo 'sshuser:abc123' | chpasswd
# ARG home=/home/sshuser/
# RUN mkdir $home/.ssh
# COPY ft_services_ssh/id_rsa.pub $home/.ssh/authorized_keys
# RUN chown sshuser:sshgroup $home/.ssh/authorized_keys && \
#     chmod 600 $home/.ssh/authorized_keys
# RUN rc-update add sshd

# ssh
USER root
RUN apk add openrc nginx openssl openssh --no-cache
RUN adduser -D admin 
RUN echo admin:admin | chpasswd
RUN touch /run/openrc/softlevel
RUN openrc
RUN rc-update add sshd

EXPOSE 80 443 22 2222

ENTRYPOINT ["sh", "/entrypoint.sh"]