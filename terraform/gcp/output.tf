output "BUILD_IP" {
  value = resource.google_compute_instance.build_server.network_interface.0.access_config.0.nat_ip
}

output "CLUSTER_IP" {
  value = resource.google_container_cluster.skripsi_cluster.endpoint
}
