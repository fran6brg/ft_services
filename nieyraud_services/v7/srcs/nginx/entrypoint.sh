rc-status
touch /run/openrc/softlevel
/etc/init.d/sshd restart
echo "root:root" | chpasswd
chown -R nginx:nginx /usr/share/nginx/html
chmod -R 777 /usr/share/nginx/html
nginx -g 'daemon off;'