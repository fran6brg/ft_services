FROM alpine:3.11.3

RUN apk -f upgrade && apk -f update
RUN apk -f add nginx mysql-client mysql-server wget
RUN apk -f add php7-fpm php7-mbstring php7-session php7-mysqli php7-gettext \
	php7-pdo php7-zip php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc \
	php7-pdo_mysql php7-pdo_sqlite php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib \
	php7-curl php7-ctype php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom

RUN wget https://fr.wordpress.org/latest-fr_FR.tar.gz && \
    tar -xvf latest-fr_FR.tar.gz
RUN mkdir /var/www/html
RUN mv wordpress /etc/nginx/site

COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY wordpress.sql /wordpress.sql
RUN chmod 777 /wordpress.sql
COPY wp-config.php /etc/nginx/site/wp-config.php


EXPOSE 5050 9000 80 3306

ENTRYPOINT ["sh", "/entrypoint.sh"]