# mkdir /run/nginx
# touch /run/nginx/nginx.pid
# /usr/sbin/nginx
# # while ! mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD; do
# # 	echo "After import";
# # 	sleep 4;
# # done
# sleep 5;

# echo "before connection";
# if ! mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'USE wordpress'; then
# 	echo "can't connect wordpress container to mysql container";
# fi
# echo "after connection";
# # if ! mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'USE wordpress'; then
# # 	echo "wordpress db not created, try creating one ...";
# # 	mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'CREATE DATABASE wordpress';
# # 	# echo "using wordpress";
# # 	# mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'USE wordpress';
# # 	echo "loading wordpress.sql";
# # 	mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD wordpress < /wordpress.sql;
# # fi
# echo "ok";
# /usr/local/bin/docker-entrypoint.sh php-fpm

mkdir /run/nginx
touch /run/nginx/nginx.pid
/usr/sbin/nginx
mysql -h $WORDPRESS_DB_HOST -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e 'USE wordpress'
/usr/local/bin/docker-entrypoint.sh php-fpm
