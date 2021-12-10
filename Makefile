cluster:
	kind create cluster --config kind-config.yaml
ingress:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	kubectl apply -f namespace.yaml
	helm install learning-ingress ingress-nginx/ingress-nginx --namespace nginx-ingress
ingress-down:
	helm delete learning-ingress
cluster-minikube:
	minikube start --nodes 2 -p multinode