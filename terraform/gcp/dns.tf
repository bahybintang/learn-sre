resource "google_dns_record_set" "rootshell-backend" {
  name         = "*.backend.${google_dns_managed_zone.rootshell.dns_name}"
  managed_zone = google_dns_managed_zone.rootshell.name
  type         = "A"
  ttl          = 300

  rrdatas = [resource.google_container_cluster.skripsi_cluster.endpoint]
}

resource "google_dns_record_set" "rootshell-frontend" {
  name         = "frontend.${google_dns_managed_zone.rootshell.dns_name}"
  managed_zone = google_dns_managed_zone.rootshell.name
  type         = "A"
  ttl          = 300

  rrdatas = [resource.google_container_cluster.skripsi_cluster.endpoint]
}

resource "google_dns_managed_zone" "rootshell" {
  name     = "rootshell"
  dns_name = "rootshell.my.id."
}
