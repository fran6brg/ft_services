#!/bin/bash

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
export MINIKUBE_HOME=~/goinfre
# export MINIKUBE_HOME=~/goinfre to do on terminal to be able to launch minikube service list

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
elif [ "$1" == "update" ]; then
	kubectl delete -k srcs/kustomization # 2> /dev/null

	cp srcs/wordpress/wordpress_dump.sql srcs/wordpress/wordpress_dump-target.sql
	sed -i '' "s/##MINIKUBE_IP##/$(minikube ip)/g" srcs/wordpress/wordpress_dump-target.sql
	eval $(minikube docker-env)
	# eval $(minikube docker-env) also to do on terminal
	docker build -t custom-nginx:1.11 srcs/nginx
	docker build -t custom-wordpress:1.9 srcs/wordpress
	docker build -t custom-mysql:1.11 srcs/mysql

	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services ip : " $(minikube ip) 2> /dev/null
elif [ "$1" == "apply" ]; then
	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services ip : " $(minikube ip) 2> /dev/null
elif [ "$1" == "dashboard" ]; then
	open $(cat logs/dashboard_logs | awk '{print $3}')
elif [ "$1" == "open" ]; then
	case $2 in
		"php")
			echo http://$(minikube ip)/phpmyadmin 2> /dev/null
			open http://$(minikube ip)/phpmyadmin 2> /dev/null
			;;
		"wordpress")
			echo http://$(minikube ip)/wordpress 2> /dev/null
			open http://$(minikube ip)/wordpress 2> /dev/null
			;;
		*)
			echo http://$(minikube ip) 2> /dev/null
			open http://$(minikube ip) 2> /dev/null
			;;
	esac 
elif [ "$1" == "addons" ]; then
	minikube addons list
elif [ !$1 ]; then
	minikube config set vm-driver virtualbox
	minikube start --memory 3000mb --memory=3000mb --extra-config=apiserver.service-node-port-range=1-32767 > logs/vm_launching_logs &
	pid=$!
	/bin/echo "Launching minikube"
	while kill -0 $pid 2> /dev/null; do
	    printf '\b%.1s' "$sp"
   		sp=${sp#?}${sp%???}
	    sleep 1;
	done
	minikube addons enable ingress
	minikube dashboard > logs/dashboard_logs &

	cp srcs/wordpress/wordpress_dump.sql srcs/wordpress/wordpress_dump-target.sql
	sed -i '' "s/##MINIKUBE_IP##/$MINIKUBE_IP/g" srcs/wordpress/wordpress_dump-target.sql
	eval $(minikube docker-env)
	docker build -t custom-nginx:1.11 srcs/nginx
	docker build -t custom-wordpress:1.9 srcs/wordpress
	docker build -t custom-mysql:1.11 srcs/mysql

	kubectl apply -k srcs/kustomization
	/bin/echo "Ft_services default : " http://$(minikube ip) 2> /dev/null
fi
