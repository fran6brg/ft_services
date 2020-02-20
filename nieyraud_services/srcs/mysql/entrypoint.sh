echo 1 && mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
cat << EOF > admin.sql
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
echo 2 && mysqld -u $MYSQL_USER --bootstrap --verbose=0 --skip-grant-tables=0 < admin.sql
echo 3 && exec /usr/bin/mysqld --user=$MYSQL_USER --console