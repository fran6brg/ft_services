FROM alpine:latest

RUN apk update && apk upgrade --available

RUN apk add --no-cache tini openrc busybox-initscripts

RUN apk add openssl && apk add vsftpd  && apk add vim

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -subj "/CN=ftps/O=ftps"

RUN apk add lftp

RUN adduser steve --disabled-password && echo steve | passwd -d steve

RUN mkdir home/steve/ftp && chmod a-w home/steve/ftp && echo "Hello World" >> home/steve/ftp/anon.txt

RUN rm etc/vsftpd/vsftpd.conf

RUN echo "steve" | tee -a /etc/vsftpd.userlist

ADD srcs/vsftpd.conf etc/vsftpd/vsftpd.conf

RUN rc-update add vsftpd && rc-status && touch run/openrc/softlevel

RUN rc-service vsftpd start && rc-status
