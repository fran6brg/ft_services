# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init_minikube.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fberger <fberger@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/12/27 13:56:12 by fberger           #+#    #+#              #
#    Updated: 2020/02/09 18:44:47 by nieyraud         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# clean
kubectl delete all --all
minikube delete
rm -rf ~/goinfre/.minikube
rm -rf ~/Library/**.42_cache_bak_**; rm -rf ~/**.42_cache_bak_**; brew cleanup
rm -rf ~/Library/Caches/*; rm ~/.zcompdump*; brew cleanup
rm -rf ~/.minikube
sh ~/Desktop/fberger/newCursus/0.fraberg/42toolbox/free_space.sh
# if needed
virtualbox destroy
pkill -9 VBox

# launch minikube
export MINIKUBE_HOME=~/sgoinfre/goinfre/Perso/nieyraud/vms/.
printf "\nlaunching minikube \n"
minikube config set vm-driver virtualbox
minikube start --disk-size 5g

# check minikube status
printf "\nminikube status \n"
minikube status

# set up the env variables necessary for Docker to interact with minikube VM
eval $(minikube docker-env)

printf "\nclean namespace \n"
kubectl delete all --all

printf "\nget pods \n"
kubectl get pods
# should return "No resources found in default namespace."

# then login on web ui dashboard
# https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
# kubectl proxy

# get token
# https://stackoverflow.com/questions/48228534/kubernetes-dashboard-access-using-config-file-not-enough-data-to-create-auth-inf
# kubectl -n kube-system get secret
# kubectl -n kube-system describe secret deployment-controller-token-pqqs8


# while config isn't good
# kubectl delete all --all
