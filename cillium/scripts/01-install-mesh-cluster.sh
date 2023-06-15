export CLUSTER1=kind-alliance-sector-01
export CLUSTER2=kind-alliance-sector-02

cillium install --context "$CLUSTER1" --cluster-name sector-01 --cluster-id 1 --encryption wireguard --helm-set "l7Proxy=false"
cillium install --context "$CLUSTER2" --cluster-name sector-02 --cluster-id 2 --encryption wireguard --helm-set "l7Proxy=false" --inherit-ca "$CLUSTER1"

cillium clustermesh enable --service-type NodePort --context $CLUSTER1
cillium clustermesh enable --service-type NodePort --context $CLUSTER2

cillium clustermesh status --context $CLUSTER1
cillium clustermesh status --context $CLUSTER2

cillium clustermesh connect --context $CLUSTER1 --destination-context $CLUSTER2