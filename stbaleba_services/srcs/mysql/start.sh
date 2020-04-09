#! /bin/sh

mysql_install_db --user=mysql --datadir=/var/lib/mysql
rc-service mariadb restart
mysql -e "CREATE DATABASE IF NOT EXISTS mysql;"
mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
tail -f /dev/null

