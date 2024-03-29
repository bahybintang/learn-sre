cluster-kind:
	kind create cluster --config kind-config.yaml
ingress:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	kubectl apply -f namespace.yaml
	helm install learning-ingress ingress-nginx/ingress-nginx --namespace nginx-ingress
ingress-minikube:
	minikube addons enable ingress
ingress-down:
	helm delete learning-ingress --namespace nginx-ingress
cluster-dev:
	minikube start --nodes 2 -p multinode
	minikube profile multinode
cluster-prod:
	minikube start --nodes 2 -p multinode-prod
	minikube profile multinode-prod
	kubectl label namespaces default istio-injection=enabled
	istioctl install
cert-manager:
	kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.yaml
cert-manager-down:
	kubectl delete -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.yaml