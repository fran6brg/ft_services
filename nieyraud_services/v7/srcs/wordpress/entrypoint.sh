mkdir /run/nginx
touch /run/nginx/nginx.pid

mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD wordpress < /wordpress.sql;
while  [ $? == 1 ]; do
	echo "Waiting for mysql to be connected";
	sleep 2;
	mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD wordpress < /wordpress.sql;
done

echo "Launching php-fpm7"
php-fpm7
echo "Launching nginx server"
nginx -g 'daemon off;'