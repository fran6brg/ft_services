FROM alpine:3.11.3

RUN apk -f update
RUN apk -f add nginx mysql-client mysql-server
RUN apk -f add wget
RUN apk -f add php7-fpm php7-mbstring php7-session php7-mysqli php7-gettext \
	php7-pdo php7-zip php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc \
	php7-pdo_mysql php7-pdo_sqlite php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib \
	php7-curl php7-ctype php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom

RUN wget -c https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz && \
    tar -xvf phpMyAdmin-4.9.4-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.4-all-languages /etc/nginx/site
RUN mkdir /etc/nginx/site/tmp

COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY config.inc.php /etc/nginx/site/config.inc.php
RUN chmod 777 /etc/nginx/site/tmp

EXPOSE 5000 80 3306 8889

CMD ["sh", "/entrypoint.sh"]