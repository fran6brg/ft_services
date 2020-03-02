# echo 1 && mysql_install_db --user=mysql > /dev/null

if [ ! -d /app/mysql/mysql ]
then
	echo Creating initial database...
	mysql_install_db --user=root > /dev/null
	echo Done!
fi

if [ ! -d /run/mysqld ]
then
	mkdir -p /run/mysqld
fi

tfile=`mktemp`
if [ ! -f "$tfile" ]
then
	echo Cannot create temp file!
	exit 1
fi

echo Created $tfile inside $PWD

cat << EOF > $tfile
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
EOF

cat $tfile

echo 2 && mysqld -u root --bootstrap --verbose=0 --skip-grant-tables=0 < $tfile

echo 3 && exec /usr/bin/mysqld --user=root --console