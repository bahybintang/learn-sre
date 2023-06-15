export CLUSTER1=kind-alliance-sector-01
export CLUSTER2=kind-alliance-sector-02

kubectl apply --context $CLUSTER1 -f https://raw.githubusercontent.com/cilium/cilium/1.13.1/examples/kubernetes/clustermesh/global-service-example/cluster1.yaml
kubectl apply --context $CLUSTER2 -f https://raw.githubusercontent.com/cilium/cilium/1.13.1/examples/kubernetes/clustermesh/global-service-example/cluster2.yaml

kubectl get service/rebel-base --context $CLUSTER2 -o json | jq .metadata.annotations

i=1
while [ $i -lt 5 ]; do kubectl --context $CLUSTER1 exec -ti deployment/x-wing -- curl rebel-base && i=$((i+1)); done

i=1
while [ $i -lt 5 ]; do kubectl --context $CLUSTER2 exec -ti deployment/x-wing -- curl rebel-base && i=$((i+1)); done