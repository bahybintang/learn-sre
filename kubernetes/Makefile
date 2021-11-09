rollout-fe:
	kubectl rollout restart deployments/frontend
rollout-be:
	kubectl rollout restart deployments/backend
deploy:
	kubectl apply -f tls-secret.yaml
	kubectl apply -f backend.yaml
	kubectl apply -f frontend.yaml
	kubectl apply -f redis.yaml
	kubectl apply -f backend-service.yaml
	kubectl apply -f frontend-service.yaml
	kubectl apply -f redis-service.yaml
	kubectl apply -f backend-ingress.yaml
	kubectl apply -f frontend-ingress.yaml