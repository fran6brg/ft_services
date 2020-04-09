#! bin/bash

#export MINIKUBE_HOME=~/goinfre
minikube config set vm-driver virtualbox
minikube start --memory 3000 --bootstrapper=kubeadm
minikube docker-env
eval $(minikube -p minikube docker-env)
#touch pasv.txt
#echo "pasv_address=" | tee pasv.txt | sed "/^pasv_address=/ s/\$/$(minikube ip)/" pasv.txt | tee -a srcs/ftps/vsftpd.conf
#rm pasv.txt
sed -i "s/mini_ip/$(minikube ip)/" srcs/ftps/vsftpd.conf
sed -i "s/mini_ip/$(minikube ip)/" srcs/telegraf/telegraf.conf
kubectl create -f srcs/ingress.yaml
minikube addons enable ingress
minikube addons enable metrics-server
docker build -t nginx-alpine ./srcs/nginx/
#kubectl apply -f srcs/service-nginx.yml
docker build -t ftps_alpine ./srcs/ftps/
#kubectl apply -f srcs/ftps.yml
#sed -i '' -e '$ d' srcs/ftps/vsftpd.conf
docker build -t wordpress_alpine ./srcs/wordpress/
#kubectl apply -f srcs/wordpress/wordpress.yml
docker build -t mysql_alpine ./srcs/mysql/
#kubectl apply -f srcs/mysql/mysql.yml
docker build -t phpmyadmin_alpine ./srcs/phpmyadmin/
docker build -t influxdb_alpine ./srcs/influxdb/
docker build -t telegraf_alpine ./srcs/telegraf/
docker build -t grafana_alpine ./srcs/grafana/
kubectl apply -k ./srcs/
sed -i "s/$(minikube ip)/mini_ip/" srcs/telegraf/telegraf.conf
sed -i "s/$(minikube ip)/mini_ip/" srcs/ftps/vsftpd.conf
#kubectl delete -n default deployment wordpress
#kubectl apply -f srcs/wordpress-deployment.yaml
minikube dashboard
