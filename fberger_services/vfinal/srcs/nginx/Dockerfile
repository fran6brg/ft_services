FROM nginx:alpine

# NGINX CONFIG
COPY default.conf /etc/nginx/conf.d/default.conf

# Get keys
RUN apk update && apk upgrade
RUN apk add openssl \
	&& openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" -addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

# Create a user account
RUN apk add --no-cache openssh-server

COPY key/id_rsa /etc/ssh/ssh_host_rsa_key
RUN chmod 700 /etc/ssh/ssh_host_rsa_key

RUN apk add --no-cache openssh-server
COPY key/id_rsa /etc/ssh/ssh_host_rsa_key
RUN chmod 700 /etc/ssh/ssh_host_rsa_key
RUN addgroup sshgroup && adduser -Ds /bin/sh -g sshgroup sshuser
RUN echo 'sshuser:test' | chpasswd
ARG home=/home/sshuser/
RUN mkdir $home/.ssh
COPY key/id_rsa.pub $home/.ssh/authorized_keys
RUN chown sshuser:sshgroup $home/.ssh/authorized_keys && \
    chmod 600 $home/.ssh/authorized_keys

EXPOSE 80 443 22

# COPY entrypoint.sh /entrypoint.sh
COPY start.sh /usr/local/bin/
RUN chmod 700 /usr/local/bin/start.sh 
ENTRYPOINT ["/usr/local/bin/start.sh"]

# Start the SSH service
# CMD service ssh start && nginx -g 'daemon off;'
CMD ["nginx", "-g", "daemon off;"]

# CMD ["sh", "/entrypoint.sh"]c 