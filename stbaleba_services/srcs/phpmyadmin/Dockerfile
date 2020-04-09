FROM alpine:3.11.3

RUN apk update && apk add vim

RUN apk add openrc

RUN apk -f add nginx

RUN rc-update add nginx

RUN mkdir /run/nginx && touch /run/nginx/nginx.pid

RUN apk add php7 php7-fpm php7-opcache && rc-update add php-fpm7

RUN apk add php7-mbstring php7-session php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

RUN rm etc/nginx/conf.d/default.conf

ADD default.conf etc/nginx/conf.d/

RUN  rc-status 

RUN touch /run/openrc/softlevel

RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz

RUN tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz && mv phpMyAdmin-5.0.2-all-languages phpmyadmin

RUN mv phpmyadmin /var/www/localhost/htdocs/phpmyadmin

ADD config.inc.php /var/www/localhost/htdocs/phpmyadmin/config.inc.php

ADD start.sh /start.sh

RUN mkdir /var/www/localhost/htdocs/phpmyadmin/tmp && chmod 777 /var/www/localhost/htdocs/phpmyadmin/tmp

RUN chmod 755 start.sh

RUN apk -f add mysql-client mysql-server

VOLUME ["/sys/fs/cgroup"]

ENTRYPOINT ["sh", "/start.sh"]

