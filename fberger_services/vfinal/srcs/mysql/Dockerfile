FROM alpine:3.11.3

RUN apk add --update mysql mysql-client
RUN mkdir /app
RUN mkdir auth_pam_tool_dir
RUN mkdir /auth_pam_tool_dir/auth_pam_tool
COPY my.cnf /etc/mysql/my.cnf
COPY my.cnf /etc/my.cnf
COPY entrypoint.sh /entrypoint.sh

EXPOSE 3306

CMD ["sh", "/entrypoint.sh"]
