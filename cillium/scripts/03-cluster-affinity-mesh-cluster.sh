kubectl --context=$CLUSTER1 annotate service rebel-base service.cilium.io/affinity=local --overwrite

kubectl --context $CLUSTER1 scale --replicas=0 deploy/rebel-base

i=1
while [ $i -lt 5 ]; do kubectl --context $CLUSTER1 exec -ti deployment/x-wing -- curl rebel-base && i=$((i+1)); done

kubectl --context $CLUSTER1 scale --replicas=2 deploy/rebel-base

i=1
while [ $i -lt 5 ]; do kubectl --context $CLUSTER1 exec -ti deployment/x-wing -- curl rebel-base && i=$((i+1)); done

kubectl --context=$CLUSTER2 annotate service rebel-base service.cilium.io/affinity=local --overwrite