mv phpMyAdmin-4.9.4-all-languages /usr/share/nginx/html/phpmyadmin
mysql -h $PMA_HOST -u $MYSQL_USER -p$MYSQL_ROOT_PASSWORD -e 'USE wordpress'
php-fpm7 -F
