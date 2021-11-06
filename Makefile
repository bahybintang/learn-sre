rollout-fe:
	kubectl rollout restart deployments/frontend
rollout-be:
	kubectl rollout restart deployments/backend