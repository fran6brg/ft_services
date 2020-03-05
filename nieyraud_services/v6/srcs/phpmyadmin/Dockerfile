FROM alpine:3.11.3

RUN apk -f update
RUN apk -f add mysql-client mysql-server wget
RUN wget -c https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz && \
    tar -xvf phpMyAdmin-4.9.4-all-languages.tar.gz
RUN mkdir /usr/share/nginx
RUN apk -f add php-fpm

COPY entrypoint.sh /entrypoint.sh
COPY www.conf /etc/php7/php-fpm.d/www.conf

EXPOSE 5000 9000

CMD ["sh", "/entrypoint.sh"]
