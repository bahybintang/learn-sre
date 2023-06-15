create-cluster:
	kind create cluster --config kind-config.yaml

install:
	cillium install

status:
	cillium status --wait

enable-hubble:
	cillium hubble enable --ui

validate:
	cillium connectivity test --request-timeout 30s --connect-timeout 10s

hubble-port-forward:
	cillium hubble port-forward

hubble-ui:
	cillium hubble ui

simulate-traffic:
	kubectl exec xwing -- curl --connect-timeout 2 -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
	kubectl exec tiefighter -- curl --connect-timeout 2 -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing

hubble-observe:
	hubble observe --label "class=xwing" --last 10

cillium-helm-install:
	helm install cilium cilium/cilium --version 1.13.1 --namespace kube-system --set operator.replicas=1

cillium-helm-enable-prometheus:
	helm upgrade cilium cilium/cilium --namespace=kube-system --reuse-values --set prometheus.enabled=true --set operator.prometheus.enabled=true

cillum-helm-enable-hubble-prometheus:
	helm upgrade cilium cilium/cilium --version 1.13.1 --namespace kube-system --reuse-values --set hubble.enabled=true --set hubble.metrics.enabled="{dns,drop,tcp,flow,port-distribution,httpV2}"

cillium-helm-add-hubble-context:
	helm upgrade cilium cilium/cilium --version 1.13.1 --namespace kube-system --reuse-values --set hubble.enabled=true --set hubble.metrics.enabled="{dns,drop:sourceContext=pod;destinationContext=pod,tcp,flow,port-distribution,httpV2}"

cillium-monitoring:
	kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.13/examples/kubernetes/addons/prometheus/monitoring-example.yaml

cillium-enable-transparent-encryption:
	helm upgrade cilium cilium/cilium --namespace kube-system \
		--reuse-values \
		--set l7Proxy=false \
		--set encryption.enabled=true \
		--set encryption.type=wireguard