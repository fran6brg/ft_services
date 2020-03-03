openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/nginx.key -out /tmp/nginx.crt -subj "/CN=nginxsvc/O=nginxsvc"
kubectl create secret tls nginxsecret --key /tmp/nginx.key --cert /tmp/nginx.crt
kubectl get secrets
kubectl create configmap nginxconfigmap --from-file=srcs/default.conf
kubectl get configmaps
