resource "digitalocean_kubernetes_cluster" "skripsi_cluster" {
  name     = "skripsi-cluster"
  region   = var.REGION
  version  = var.KUBERNETES_VERSION
  vpc_uuid = resource.digitalocean_vpc.skripsi.id

  node_pool {
    name       = "worker-pool"
    size       = "s-1vcpu-2gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 2
  }
}
