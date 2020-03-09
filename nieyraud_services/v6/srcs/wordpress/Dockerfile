FROM alpine:3.11.3

RUN apk -f upgrade && apk -f update
RUN apk -f add nginx mysql-client mysql-server php-fpm7.4 wget
RUN wget https://fr.wordpress.org/latest-fr_FR.tar.gz && \
    tar -xvf latest-fr_FR.tar.gz
COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY wordpress.sql /wordpress.sql
RUN chmod 777 /wordpress.sql
COPY wp-config.php /wp-config.php

EXPOSE 5050
ENTRYPOINT ["sh", "/entrypoint.sh"]