provider "google" {
  credentials = file("creds.json")
  project     = var.PROJECT_ID
  region      = var.DEFAULT_REGION
}

provider "kubernetes" {
  host  = resource.google_container_cluster.skripsi_cluster.endpoint
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    resource.google_container_cluster.skripsi_cluster.master_auth.0.cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = resource.google_container_cluster.skripsi_cluster.endpoint
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      resource.google_container_cluster.skripsi_cluster.master_auth.0.cluster_ca_certificate
    )
  }
}
