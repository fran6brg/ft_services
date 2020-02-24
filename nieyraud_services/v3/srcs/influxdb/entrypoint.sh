influxd &
sleep 5;
influx -execute "CREATE USER admin WITH PASSWORD 'admin' WITH ALL PRIVILEGES"
influx -username admin -password admin -execute "CREATE DATABASE ft_services"
influx -username admin -password admin -execute "USE ft_services"
kill $(pgrep influxd)
influxd &
sh