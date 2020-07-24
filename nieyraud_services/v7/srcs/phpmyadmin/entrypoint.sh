mkdir /run/nginx
touch /run/nginx/nginx.pid
php-fpm7
nginx -g 'daemon off;'