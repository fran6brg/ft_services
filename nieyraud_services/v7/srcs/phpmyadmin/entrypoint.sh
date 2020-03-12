mysql -h $PMA_HOST -u $MYSQL_USER -p$MYSQL_ROOT_PASSWORD < /etc/nginx/site/sql/create_tables.sql
while [ $? == 1 ]; do
	sleep 2;
	mysql -h $PMA_HOST -u $MYSQL_USER -p$MYSQL_ROOT_PASSWORD < /etc/nginx/site/sql/create_tables.sql
done
mkdir /run/nginx
touch /run/nginx/nginx.pid
php-fpm7
nginx -g 'daemon off;'