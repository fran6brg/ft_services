#! /bin/sh

mysql -h mysql -u root -ppassword;
while [ $? == 1 ]; 
do
  mysql -h mysql -u root -ppassword;
done
echo "found";
mysql -h mysql -u root -ppassword -e 'USE wordpress';
if [ $? == 1 ]; then

    mysql -h mysql -u root -ppassword -e 'CREATE DATABASE IF NOT EXISTS wordpress';

    while [ $? == 1 ]; do
	 mysql -h mysql -u root -ppassword -e 'CREATE DATABASE IF NOT EXISTS wordpress';
     done
     echo "good";
     mysql -h mysql -u root -ppassword wordpress < /wordpress.sql;
     while [ $? == 1 ]; do
	 mysql -h mysql -u root -ppassword wordpress < /wordpress.sql;
     done
fi
echo "finish";

mv /usr/share/wordpress/* /var/www/localhost/htdocs/wordpress/
rc-service php-fpm7 start
tail -f /dev/null
