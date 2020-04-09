FROM alpine:latest

RUN apk update && apk upgrade --available

RUN apk add --no-cache openrc

RUN apk add openssl && apk add vsftpd  && apk add vim

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -subj "/CN=ftps/O=ftps"

RUN apk add lftp

RUN adduser steve --disabled-password && echo steve | passwd -d steve

RUN mkdir home/steve/ftp && echo "Hello World" >> home/steve/ftp/anon.txt

RUN chmod 666 home/steve/ftp/anon.txt

RUN rm etc/vsftpd/vsftpd.conf

RUN chmod 777 home/steve/ftp/ && chown -R steve home/steve/ftp

RUN echo "steve" | tee -a /etc/vsftpd.userlist

ADD vsftpd.conf etc/vsftpd/vsftpd.conf

RUN rc-update add vsftpd && rc-status

ADD start_ftps.sh /start_ftps.sh

RUN chmod 755 /start_ftps.sh

VOLUME ["/sys/fs/cgroup"]

EXPOSE 21

CMD ["/start_ftps.sh"]
