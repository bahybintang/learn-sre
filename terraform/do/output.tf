output "KUBE_ADDRESS" {
  value = resource.digitalocean_kubernetes_cluster.skripsi_cluster.endpoint
}
