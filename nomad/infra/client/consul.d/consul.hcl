data_dir = "/opt/consul/data"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
client_addr = "0.0.0.0"
advertise_addr = "{{ GetInterfaceIP \"eth1\" }}"

log_level = "INFO"

server = false
ui = false
retry_join = ["192.168.69.2"]

recursors = ["8.8.8.8", "1.1.1.1"]

service {
    name = "consul"
}

connect {
  enabled = true
}

ports {
  grpc = 8502
  dns  = 53
}