cluster:
	minikube start -p monitoring
	minikube profile monitoring
# Don't use
install:
	helm install elasticsearch elastic/elasticsearch -f ./elastic-helm.yaml
init:
	kubectl create -f https://download.elastic.co/downloads/eck/1.9.0/crds.yaml
	kubectl apply -f https://download.elastic.co/downloads/eck/1.9.0/operator.yaml