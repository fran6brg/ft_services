# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fberger <fberger@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/12/27 13:56:12 by fberger           #+#    #+#              #
#    Updated: 2020/02/10 12:50:38 by fberger          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# onboarding (do it once) -----------------------------------------------------

# brew install minikube
# minikube start
# move ~/.minikube in /sgoinfre/goinfre/Perso/fberger/
# ln -s /sgoinfre/goinfre/Perso/fberger/.minikube ~/.minikube
# minikube delete

# clean before (re)launch minikube --------------------------------------------

# kubectl delete all --all
# minikube delete
# rm -rf ~/goinfre/.minikube
# rm -r ~/Library/Caches/*; rm ~/.zcompdump*; brew cleanup
# rm -rf ~/Library/**.42_cache_bak_**; rm -rf ~/**.42_cache_bak_**; brew cleanup
sh free_space.sh
virtualbox destroy
# Dont't forget to click red cross to quit virtualbox ui


# launch minikube -------------------------------------------------------------
# (to do from shell session in /sgoinfre/goinfre/Perso/fberger)

# set variable for current shell and all processes started from current shell:
export MINIKUBE_HOME=~/goinfre
# nb : if troubles with the script then copy paste the previous line directly in the shell

printf "\nlaunching minikube \n"
minikube config set vm-driver virtualbox
minikube start --disk-size 5g

# check minikube status
printf "\nminikube status \n"
minikube status

# browse dashboard
minikube dashboard

# set up the env variables necessary for Docker to interact with minikube VM
eval $(minikube docker-env)

# ... -------------------------------------------------------------------------
