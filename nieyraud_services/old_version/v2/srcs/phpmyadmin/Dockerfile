FROM phpmyadmin/phpmyadmin:fpm-alpine

RUN apk -f update
RUN apk -f add nginx mysql-client mysql-server

COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 5000

CMD ["sh", "/entrypoint.sh"]