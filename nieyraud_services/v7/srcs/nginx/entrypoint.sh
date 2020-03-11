php-fpm7
mv /index.nginx-debian.html /usr/share/nginx/html/.

echo "fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;" >> /etc/nginx/fastcgi_params
chown -R nginx:nginx /etc/php7
chown -R nginx:nginx /usr/share/nginx/html
chown -R nginx:nginx /run/php/php7.3-fpm.sock
chmod -R 777 /run/php/php7.3-fpm.sock
chmod -R 777 /etc/php7
chmod -R 777 /usr/share/nginx/html
nginx -g 'daemon off;'