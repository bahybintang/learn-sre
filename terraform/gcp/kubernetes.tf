resource "google_container_cluster" "skripsi_cluster" {
  name     = "skripsi-cluster"
  location = var.DEFAULT_REGION

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network = resource.google_compute_network.skripsi_network.name

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 2
      maximum       = 10
    }

    resource_limits {
      resource_type = "memory"
      maximum       = 5
    }
  }
}

resource "google_container_node_pool" "skripsi_nodes" {
  name               = "skripsi-nodes"
  location           = var.DEFAULT_REGION
  cluster            = google_container_cluster.skripsi_cluster.name
  initial_node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 1
  }

  node_config {
    preemptible  = true

    # 2 vCPU 1 GB RAM
    machine_type = "e2-micro"
  }
}

data "google_client_config" "provider" {}
