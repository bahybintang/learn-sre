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
	kubectl apply -f backend-ingress.yaml
	kubectl apply -f frontend-ingress.yaml
	kubectl apply -f backend-hpa.yaml
delete:
	kubectl delete -f redis-cfg.yaml
	kubectl delete -f redis-volume.yaml
	kubectl delete -f redis-service.yaml
	kubectl delete -f redis.yaml
	kubectl delete -f backend.yaml
	kubectl delete -f frontend.yaml
	kubectl delete -f backend-service.yaml
	kubectl delete -f frontend-service.yaml
	kubectl delete -f backend-ingress.yaml
	kubectl delete -f frontend-ingress.yaml
	kubectl delete -f backend-hpa.yaml