mkdir /run/nginx
touch /run/nginx/nginx.pid
/usr/sbin/nginx

mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD;
while  [ $? == 1 ]; do
	echo "Waiting for mysql to be launch";
	sleep 2;
	mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD;
done
echo "Mysql found";
mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'USE wordpress';
if [ $? == 1 ] ; then
	echo "Creating wordpress database";
	mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'CREATE DATABASE IF NOT EXISTS wordpress';
	while  [ $? == 1 ]; do
		echo "Waiting for mysql to be connected again";
		sleep 2;
		mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'CREATE DATABASE IF NOT EXISTS wordpress';
	done
	echo "Importing template";
	mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD wordpress < /wordpress.sql;
	while  [ $? == 1 ]; do
		echo "Waiting for mysql to be connected again";
		sleep 2;
		mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD wordpress < /wordpress.sql;
	done
fi
echo "Database set up";
# /usr/local/bin/docker-entrypoint.sh php-fpm
# cp /wp-config.php /var/www/html/wp-config.php
