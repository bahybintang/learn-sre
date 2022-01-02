install:
	helm repo add fluxcd https://charts.fluxcd.io
	helm upgrade -i flux-dev fluxcd/flux --namespace flux --values values-dev-flux.yaml