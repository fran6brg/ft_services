FROM alpine:3.11.3

RUN apk update && apk upgrade --available

RUN apk add --no-cache openrc

RUN apk add openssl && apk add vsftpd  && apk add vim

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -subj "/CN=ftps/O=ftps"

#ADD vsftpd.pem  /etc/ssl/private/vsftpd.pem

RUN apk add lftp

ENV FTPS_USER=fberger

RUN adduser $FTPS_USER --disabled-password && echo $FTPS_USER | passwd -d $FTPS_USER

RUN mkdir home/$FTPS_USER/ftp && echo "Hello World" >> home/$FTPS_USER/ftp/anon.txt

RUN chmod 666 home/$FTPS_USER/ftp/anon.txt

RUN rm etc/vsftpd/vsftpd.conf

RUN chmod 777 home/$FTPS_USER/ftp/ && chown -R $FTPS_USER home/$FTPS_USER/ftp

RUN echo $FTPS_USER | tee -a /etc/vsftpd.userlist

ADD vsftpd.conf etc/vsftpd/vsftpd.conf

RUN rc-update add vsftpd && rc-status

ADD entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

VOLUME ["/sys/fs/cgroup"]

EXPOSE 21

CMD ["/entrypoint.sh"]
