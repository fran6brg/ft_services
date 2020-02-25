#!/bin/bash

cnt=$(cat count)
cnt=$((cnt+1))
echo $cnt > count

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
#echo "DOCKER_PATH =" $DOCKER_PATH

function image_build
{
	eval $(minikube -p minikube docker-env)
	docker build $DOCKER_PATH/nginx -t custom_nginx
	docker build $DOCKER_PATH/wordpress -t custom_wp
	docker build $DOCKER_PATH/mysql -t custom_mysql
	docker build $DOCKER_PATH/phpmyadmin -t custom_phpmyadmin
	docker build $DOCKER_PATH/telegraf -t custom_telegraf
	docker build $DOCKER_PATH/grafana -t custom_grafana
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
	sed -i '' s/$(awk -F: '{print $2}' <<< $(cat srcs/wordpress/wordpress.sql | grep siteurl | awk '{print $3}') | cut -c 3-)/$(minikube ip)/g srcs/wordpress/wordpress.sql
	minikube addons enable ingress
	minikube addons enable metrics-server
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
	sed -i '' s/$(awk -F: '{print $2}' <<< $(cat srcs/wordpress/wordpress.sql | grep siteurl | awk '{print $3}') | cut -c 3-)/$(minikube ip)/g srcs/wordpress/wordpress.sql
	minikube addons enable ingress
	minikube dashboard > logs/dashboard_logs &
	image_build
	kubectl apply -k srcs/kustomization
	minikube service list
}

function clear
{
	kubectl delete all --all
	kubectl delete pvc --all
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
elif [ "$1" == "update" ]; then
	kubectl delete all --all
	image_build
	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services ip : " $(minikube ip) 2> /dev/null
elif [ "$1" == "apply" ]; then
	image_build
	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services ip : " $(minikube ip) 2> /dev/null
elif [ "$1" == "reapply" ]; then
	clear
	image_build
	kubectl apply -k srcs/kustomization
	minikube service list
elif [ "$1" == "dashboard" ]; then
	open $(cat logs/dashboard_logs | awk '{print $3}')
elif [ "$1" == "build" ]; then
	image_build;
elif [ "$1" == "open" ]; then
	case $2 in
		"wordpress")
			echo $(minikube service list | grep wordpress-svc | awk '{print $6}') 2> /dev/null
			open $(minikube service list | grep wordpress-svc | awk '{print $6}') 2> /dev/null
			;;
		"phpmyadmin")
			echo $(minikube service list | grep phpmyadmin-svc | awk '{print $6}') 2> /dev/null
			open $(minikube service list | grep phpmyadmin-svc | awk '{print $6}') 2> /dev/null
			;;
		*)
			echo http://$(minikube ip) 2> /dev/null
			open http://$(minikube ip) 2> /dev/null
			;;
	esac
elif [ "$1" == "addons" ]; then
	minikube addons list
elif [ "$1" == "start" ]; then
	vm_start;
elif [ "$1" == "env" ]; then
	echo "export MINIKUBE_HOME=~/goinfre"
	echo "eval $(minikube docker-env)"
elif [ "$1" == "count" ]; then
	cat count
elif [ !$1 ]; then
	launcher;
fi
