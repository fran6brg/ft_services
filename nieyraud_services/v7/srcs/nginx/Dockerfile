FROM alpine:3.11.3

# NGINX CONFIG

RUN apk update && apk upgrade
RUN apk add nginx
RUN mkdir -p /etc/ssl/private/ /etc/ssl/certs/
RUN apk add openssl \
	&& openssl req -x509 -nodes -days 365 \
	-subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" \
	-addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt

RUN apk add openrc musl busybox openssh busybox-extras
RUN rc-update add sshd
RUN mkdir /run/nginx && touch /run/nginx/nginx.pid && mkdir -p /usr/share/nginx/html
RUN adduser nginx nginx
RUN chown -R nginx:nginx /etc/nginx

COPY sshd_config /etc/ssh/sshd_config
COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/.
COPY entrypoint.sh /entrypoint.sh

EXPOSE 80 443 22

ENTRYPOINT ["sh", "/entrypoint.sh"]