rollout-fe:
	kubectl rollout restart deployments/frontend
rollout-be:
	kubectl rollout restart deployments/backend
deploy:
	kubectl apply -f redis-cfg.yaml
	kubectl apply -f redis-volume.yaml
	kubectl apply -f redis-service.yaml
	kubectl apply -f redis.yaml
	kubectl apply -f backend.yaml
	kubectl apply -f frontend.yaml
	kubectl apply -f backend-service.yaml
	kubectl apply -f frontend-service.yaml
	kubectl apply -f backend-hpa.yaml
delete:
	kubectl delete -f backend-hpa.yaml
	kubectl delete -f frontend-service.yaml
	kubectl delete -f backend-service.yaml
	kubectl delete -f frontend.yaml
	kubectl delete -f backend.yaml
	kubectl delete -f redis.yaml
	kubectl delete -f redis-service.yaml
	kubectl delete -f redis-volume.yaml
	kubectl delete -f redis-cfg.yaml
cert:
	kubectl apply -f issuer.yaml
	kubectl apply -f certificate.yaml
fwd-kiali:
	kubectl port-forward -n istio-system service/kiali 20001:20001