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

if [ "$1" = "remove" ]; then
	export MINIKUBE_HOME=~/goinfre;
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
	open $(cat logs/dashboard_logs | cut -c 12- | rev | cut -c 27- | rev)
elif [ !$1 ]; then
	export MINIKUBE_HOME=~/goinfre
	minikube config set vm-driver virtualbox
	minikube start --memory 3g &> logs/vm_launching_logs
	pid=$!
	/bin/echo -n "Launching minikube"
	while kill -0 $pid 2> /dev/null; do
	    /bin/echo -n " .";
	    sleep 1;
	done
	minikube dashboard &> logs/dashboard_logs
	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services ip : " $(minikube ip) 2> /dev/null
fi

