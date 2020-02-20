mkdir /run/nginx
touch /run/nginx/nginx.pid
/usr/sbin/nginx
while ! mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD; do
	echo "After import";
	sleep 4;
done
# mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD;
# echo after;
# sleep 4;
if ! mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'USE wordpress'; then
	mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;';
	mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD wordpress < /wordpress.sql;
fi
/usr/local/bin/docker-entrypoint.sh php-fpm
