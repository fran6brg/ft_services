mysql -h $PMA_HOST -u $MYSQL_USER -p$MYSQL_ROOT_PASSWORD -e 'USE wordpress'
sh /docker-entrypoint.sh php-fpm
mkdir /run/nginx
touch /run/nginx/nginx.pid
/usr/sbin/nginx
php-fpm