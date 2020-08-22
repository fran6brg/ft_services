#!/bin/bash

cnt=$(cat count)
cnt=$((cnt+1))
echo $cnt > count

rose='\033[1;31m'
violetfonce='\033[0;35m'
violetclair='\033[1;35m'
neutre='\033[0m'
cyanfonce='\033[0;36m'
cyanclair='\033[1;36m'
vertfonce='\033[0;32m'
vertclair='\033[1;32m'
rouge='\033[31m'

set -e

#############################
#		CLEANSE				#
#############################

# rm -rf ~/Library/Caches/* 
# rm -rf ~/.zcompdump* 
# rm -rf ~/Library/**.42_cache_bak* 
# rm -rf ~/**.42_cache_bak 
# rm -rf ~/Library/**.42_cache_bak_** 
# rm -rf ~/**.42_cache_bak_** 
# brew cleanup 


#####################################################################################################
#									MINIKUBE LAUNCHER												#
#####################################################################################################

#############################
#		FUNCTIONS			#
#############################

DOCKER_PATH=$PWD/srcs
NGINX_PATH=$PWD/srcs/nginx
function apply_kustom
{
	set +e
	rm ~/.ssh/known_hosts
	kubectl create secret generic ssh-keys \
		--from-file=ssh-privatekey=$NGINX_PATH/.ssh/id_rsa \
		--from-file=ssh-publickey=$NGINX_PATH/.ssh/id_rsa.pub
	set -e
	kubectl apply -k srcs/kustomization
	sleep 10
	kubectl apply -f srcs/kustomization/telegraf.yaml
}

function image_build
{
	eval $(minikube -p minikube docker-env)
	docker build $DOCKER_PATH/nginx -t custom_nginx
	docker build $DOCKER_PATH/wordpress -t custom_wp
	docker build $DOCKER_PATH/mysql -t custom_mysql
	docker build $DOCKER_PATH/phpmyadmin -t custom_phpmyadmin
	docker build $DOCKER_PATH/telegraf -t custom_telegraf
	docker build $DOCKER_PATH/grafana -t custom_grafana
	docker build $DOCKER_PATH/ftps -t custom_ftps
	docker build $DOCKER_PATH/influxdb -t custom_influxdb

}

function vm_start
{
	minikube config set vm-driver virtualbox
	minikube start --memory 3g > logs/vm_launching_logs &
	pid=$!
	/bin/echo "Launching minikube"
	while kill -0 $pid 2> /dev/null; do
	    printf '\b%.1s' "$sp"
   		sp=${sp#?}${sp%???}
	    sleep 1;
	done
	sed s/__MINIKUBEIP__/$(minikube ip)/g < srcs/telegraf/telegraf_generic.conf > srcs/telegraf/telegraf.conf
	# sed 's/__MINIKUBEIP__/192.168.99.6/g' < srcs/wordpress/wordpress_generic.sql > srcs/wordpress/wordpress.sql
	minikube addons enable metrics-server
	minikube addons enable metallb
	minikube dashboard > logs/dashboard_logs &
}

function launcher
{
	minikube config set vm-driver virtualbox
	minikube start --memory 3g > logs/vm_launching_logs &
	pid=$!
	/bin/echo "Launching minikube"
	while kill -0 $pid 2> /dev/null; do
	    printf '\b%.1s' "$sp"
   		sp=${sp#?}${sp%???}
	    sleep 1;
	done
	minikube addons enable metrics-server
	minikube addons enable metallb
	minikube dashboard > logs/dashboard_logs &
	image_build
	apply_kustom
	ip
}

function script_help
{
	echo "setup.sh: Optiens"
	echo "usage: sh setup.sh [options]"
	echo "Options :"
	echo "\\t remove\\t: Remove the VM"
	echo "\\t stop\\t: Shut down the VM"
	echo "\\t list\\t: List all services of minikube"
	echo "\\t reapply: Remove all objects inside the cluster then apply."
	echo "\\t update\\t: Equivalent of reapply except that it keep persistent volume up"
	echo "\\t apply\\t: Apply every yaml files inside kustomization directory."
	echo "\\t build\\t: Build images"
	echo "\\t env\\t: Print export command to modify env: eval \$(sh setup.sh env)"
	echo "\\t count\\t: Print the number of time the script as been launched."
}

function clear
{
	kubectl delete all --all
	kubectl delete pvc --all
}

function logs
{
	case $1 in
		"nginx")
			echo "$cyanfonce Nginx access log :$neutre"
			kubectl exec $(kubectl get pods | grep nginx | awk '{print $1}') cat /var/log/nginx/access.log
			echo "$cyanfonce Nginx error log :$neutre"
			kubectl exec $(kubectl get pods | grep nginx | awk '{print $1}') cat /var/log/nginx/error.log
			;;
		"php")
			echo "$cyanfonce PHP-FPM error log :$neutre"
			kubectl exec $(kubectl get pods | grep nginx | awk '{print $1}') cat var/log/php7/error.log
			;;
		*)
			echo "Please enter the service you want to print logs"
	esac
}

function enter
{
	case $1 in
		"nginx")
			kubectl exec -it $(kubectl get pods | grep nginx | awk '{print $1}') sh
			;;
		"pma")
			kubectl exec -it $(kubectl get pods | grep phpmyadmin | awk '{print $1}') sh
			;;
		"wordpress")
			kubectl exec -it $(kubectl get pods | grep wordpress | awk '{print $1}') sh
			;;
		"phpmyadmin")
			kubectl exec -it $(kubectl get pods | grep phpmyadmin | awk '{print $1}') sh
			;;
		"ftps")
			kubectl exec -it $(kubectl get pods | grep ftps | awk '{print $1}') sh
			;;
		*)
			echo "Please choose a pod to enter"
	esac
}

function ip
{
	echo "|----------------------|---------------------------|--------------------------------|"
	echo "| default      \\t       | Ft_services ip\\t\\t   | http://$(minikube ip) \\t    |" 2> /dev/null
	echo "|----------------------|---------------------------|--------------------------------|"
}

#########################
#		MAIN SCRIPT		#
#########################

# clock_1='\U0001F551'
# clock_2='\U0001F552'
# clock_3='\U0001F553'
# clock_4='\U0001F554'
# clock_5='\U0001F555'
# clock_6='\U0001F556'
# clock_7='\U0001F557'
# sp="$clock_1$clock_2$clock_3$clock_4$clock_5$clock_6$clock_7"

sp="/-\|"
export MINIKUBE_HOME=~/goinfre


if [ "$1" = "remove" ]; then
	case $2 in
		"pods")
			kubectl delete all --all
			;;
		*)
			kill $(ps aux | grep "\bminikube dashboard\b" | awk '{print $2}') 2> /dev/null
			minikube delete
			;;
	esac
elif [ "$1" = "stop" ]; then
	kubectl delete -k srcs/kustomization
	minikube stop;
elif [ "$1" = "list" ]; then
	minikube service list;
	ip;
elif [ "$1" == "update" ]; then
	kubectl delete all --all
	image_build
	apply_kustom
	ip;
elif [ "$1" == "apply" ]; then
	apply_kustom
	ip;
elif [ "$1" == "reapply" ]; then
	clear
	image_build
	apply_kustom
	minikube service list
	ip;
elif [ "$1" == "dashboard" ]; then
	open $(cat logs/dashboard_logs | awk '{print $3}')
elif [ "$1" == "build" ]; then
	image_build;
elif [ "$1" == "addons" ]; then
	minikube addons list
elif [ "$1" == "start" ]; then
	launcher;
elif [ "$1" == "logs" ]; then
	logs $2;
elif [ "$1" == "enter" ]; then
	enter $2;
elif [ "$1" == "env" ]; then
	echo "export MINIKUBE_HOME=~/goinfre"
	echo "eval $(minikube docker-env)"
elif [ "$1" == "count" ]; then
	cat count
elif [ "$1" == "sed" ]; then
	sed s/__MINIKUBEIP__/$(minikube ip)/g < srcs/telegraf/telegraf_generic.conf > srcs/telegraf/telegraf.conf
elif [ !$1 ]; then
	script_help;
fi
