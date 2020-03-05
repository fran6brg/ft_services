mkdir -p  /run/mysqld

mysql_install_db --user=root --basedir=/usr
cat << EOF > admin.sql
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
mysqld -u $MYSQL_USER --bootstrap --verbose=0 --skip-grant-tables=0 < admin.sql
exec /usr/bin/mysqld --user=$MYSQL_USER --console