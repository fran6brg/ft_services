#!/bin/bash

echo "Une fois de plus, ca nous fais chier" >> count

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
echo "DOCKER_PATH =" $DOCKER_PATH

function image_build
{
	eval $(minikube -p minikube docker-env)
	docker build $DOCKER_PATH/nginx -t custom_nginx
	docker build $DOCKER_PATH/wordpress -t custom_wp
	docker build $DOCKER_PATH/mysql -t custom_mysql
	docker build $DOCKER_PATH/phpmyadmin -t custom_phpmyadmin
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
	minikube addons enable ingress
	minikube dashboard > logs/dashboard_logs &
}

function sed_ip
{
	cp file.txt file_test.txt
	path_1 = "file.txt"
	old_ip = $(awk -F: '{print $2}' <<< $(cat $(path_1) | grep siteurl | awk '{print $3}'| cut -c 3-)
	echo $(sed 's/$(old_ip)/abc/g' ${array[$i-1]})
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

	minikube addons enable ingress
	minikube dashboard > logs/dashboard_logs &
	image_build
	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services default : " http://$(minikube ip) 2> /dev/null
}

#########################
#		MAIN SCRIPT		#
#########################

sp="/-\|"
export MINIKUBE_HOME=~/goinfre


if [ "$1" = "remove" ]; then
	case $2 in
		"pods")
			kubectl delete all --all
			kubectl delete pvc --all
			;;
		*)
			kill $(ps aux | grep "\bminikube dashboard\b" | awk '{print $2}') 2> /dev/null
			minikube delete
			;;
	esac
elif [ "$1" = "stop" ]; then
	kubectl delete -k srcs/kustomization
	minikube stop;
elif [ "$1" == "update" ]; then
	kubectl delete -k srcs/kustomization 2> /dev/null
	image_build
	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services ip : " $(minikube ip) 2> /dev/null
elif [ "$1" == "apply" ]; then
	image_build
	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services ip : " $(minikube ip) 2> /dev/null
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
	cat count | wc -l
elif [ "$1" == "sed" ]; then
	sed_ip;
elif [ !$1 ]; then
	launcher;
fi
