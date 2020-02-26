FROM nginx:alpine

RUN apk add --update openssh

COPY entrypoint /entrypoint

ENTRYPOINT sh /entrypoint

EXPOSE 443 80 22