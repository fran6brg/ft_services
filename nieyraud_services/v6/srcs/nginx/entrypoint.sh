php-fpm7
chmod 777 /run/php/php7.3-fpm.sock
chown -R nginx:nginx /usr/share/nginx/html
chmod -R 777 /usr/share/nginx/html
nginx -g 'daemon off;'