FROM alpine:3.11.3

RUN apk update && apk add vim

RUN apk add openrc

RUN apk -f add nginx

RUN rc-update add nginx

RUN mkdir /run/nginx && touch /run/nginx/nginx.pid

RUN apk add php7 php7-fpm php7-opcache && rc-update add php-fpm7

RUN apk add php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

RUN rm etc/nginx/conf.d/default.conf

ADD default.conf etc/nginx/conf.d/

RUN  rc-status 

RUN touch /run/openrc/softlevel

RUN wget https://wordpress.org/latest.tar.gz

RUN tar xzvf latest.tar.gz && mv wordpress /usr/share/wordpress

#RUN ln -s /usr/share/wordpress/ /var/www/localhost/htdocs/

ADD start.sh /start.sh

RUN chmod 755 start.sh

ADD wp-config.php /usr/share/wordpress/

ADD wordpress.sql /wordpress.sql

RUN chmod 777 wordpress.sql

RUN  apk -f add mysql-client mysql-server

VOLUME ["/sys/fs/cgroup"]

ENTRYPOINT ["sh", "/start.sh"]

