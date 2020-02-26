influxd &
sleep 5;
influx -execute "CREATE USER admin WITH PASSWORD 'admin' WITH ALL PRIVILEGES"
influx -username admin -password admin -execute "CREATE DATABASE target_influxdb"
influx -username admin -password admin -execute "USE target_influxdb"
kill $(pgrep influxd)
influxd &
sh