cluster:
	minikube start -p monitoring
	minikube profile monitoring
install:
	helm install elasticsearch elastic/elasticsearch -f ./elastic-helm.yaml
  k apply -f ./manifest
init:
	kubectl create -f https://download.elastic.co/downloads/eck/1.9.0/crds.yaml
	kubectl apply -f https://download.elastic.co/downloads/eck/1.9.0/operator.yaml