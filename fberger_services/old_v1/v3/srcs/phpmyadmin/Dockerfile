FROM alpine

# RUN apk update && apk add nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint /entrypoint

EXPOSE 5000

CMD ["sh", "/entrypoint.sh"]