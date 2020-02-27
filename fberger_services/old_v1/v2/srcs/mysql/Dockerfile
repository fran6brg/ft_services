FROM alpine:latest

RUN apk add --update mysql mysql-client
RUN mkdir app
RUN mkdir auth_pam_tool_dir
RUN mkdir /auth_pam_tool_dir/auth_pam_tool
COPY admin.sql /admin.sql
COPY my.cnf /etc/my.cnf
COPY entrypoint /entrypoint

EXPOSE 3306

CMD ["sh", "/entrypoint"]