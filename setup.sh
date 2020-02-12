#!/bin/bash

#############################
#		CLEANSE				#
#############################

rm -r ~/Library/Caches/* 2> /dev/null
rm ~/.zcompdump* 2> /dev/null
rm -rf ~/Library/**.42_cache_bak* 2> /dev/null
rm -rf ~/**.42_cache_bak 2> /dev/null
rm -rf ~/Library/**.42_cache_bak_** 2> /dev/null
rm -rf ~/**.42_cache_bak_** 2> /dev/null
brew cleanup 2> /dev/null


#############################
#	MINIKUBE LAUNCH			#
#############################

# clock_1='\U0001F551'
# clock_2='\U0001F552'
# clock_3='\U0001F553'
# clock_4='\U0001F554'
# clock_5='\U0001F555'
# clock_6='\U0001F556'
# clock_7='\U0001F557'
# sp="$clock_1$clock_2$clock_3$clock_4$clock_5$clock_6$clock_7"
sp="/-\|"

if [ "$1" = "remove" ]; then
	export MINIKUBE_HOME=~/goinfre;
	kill $(ps aux | grep "\bminikube dashboard\b" | awk '{print $2}') 2> /dev/null
	minikube delete;
elif [ "$1" = "stop" ]; then
	export MINIKUBE_HOME=~/goinfre;
	minikube stop;
elif [ "$1" == "update" ]; then
	export MINIKUBE_HOME=~/goinfre
	kubectl delete -k srcs/kustomization
	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services ip : " $(minikube ip) 2> /dev/null
elif [ "$1" == "dashboard" ]; then
	open $(cat logs/dashboard_logs | awk '{print $3}')
elif [ !$1 ]; then
	export MINIKUBE_HOME=~/goinfre
	minikube config set vm-driver virtualbox
	minikube start --memory 3g > logs/vm_launching_logs &
	minikube addons enable ingress
	pid=$!
	/bin/echo "Launching minikube"
	while kill -0 $pid 2> /dev/null; do
	    printf '\b%.1s' "$sp"
   		sp=${sp#?}${sp%???}
	    sleep 1;
	done
	minikube dashboard > logs/dashboard_logs &	
	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services ip : " $(minikube ip) 2> /dev/null
fi
