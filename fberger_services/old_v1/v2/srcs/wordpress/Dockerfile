FROM wordpress:php7.4-fpm-alpine

RUN apk -f upgrade && apk -f update
RUN apk -f add nginx mysql-client mysql-server

COPY entrypoint /entrypoint
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
ENTRYPOINT ["sh", "/entrypoint"]