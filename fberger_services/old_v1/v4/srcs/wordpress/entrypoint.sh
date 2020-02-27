mkdir /run/nginx
touch /run/nginx/nginx.pid
/usr/sbin/nginx
mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'USE wordpress'
/usr/local/bin/docker-entrypoint.sh php-fpm
