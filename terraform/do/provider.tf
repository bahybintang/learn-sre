terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.DO_TOKEN
}

provider "kubernetes" {
  host  = resource.digitalocean_kubernetes_cluster.skripsi_cluster.endpoint
  token = resource.digitalocean_kubernetes_cluster.skripsi_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    resource.digitalocean_kubernetes_cluster.skripsi_cluster.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = resource.digitalocean_kubernetes_cluster.skripsi_cluster.endpoint
    token = resource.digitalocean_kubernetes_cluster.skripsi_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(
      resource.digitalocean_kubernetes_cluster.skripsi_cluster.kube_config[0].cluster_ca_certificate
    )
  }
}
