#! /bin/sh

rc-service influxdb restart

influx -execute "CREATE USER admin WITH PASSWORD 'password' WITH ALL PRIVILEGES"
while [ $? == 1 ];
do
  influx -execute "CREATE USER admin WITH PASSWORD 'password' WITH ALL PRIVILEGES"
done
echo "admin created"
influx -username admin -password password -execute "CREATE DATABASE influx_db"

influx -username admin -password password -execute "CREATE USER influx_user WITH PASSWORD 'password'"

influx -username admin -password password -execute "GRANT ALL ON influx_db TO influx_user"

tail -f /dev/null
