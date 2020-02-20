FROM alpine:latest

RUN apk add --update mysql mysql-client
RUN mkdir auth_pam_tool_dir
RUN mkdir /auth_pam_tool_dir/auth_pam_tool
COPY wordpress.sql /var/lib/mysql/wordpress.sql
COPY my.cnf /etc/mysql/my.cnf
COPY my.cnf /etc/my.cnf
COPY entrypoint.sh /entrypoint.sh

EXPOSE 3306

CMD ["sh", "/entrypoint.sh"]