data_dir = "/opt/consul/data"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
client_addr = "0.0.0.0"
advertise_addr = "{{ GetInterfaceIP \"eth1\" }}"

bootstrap_expect = 1

log_level = "INFO"

server = true
ui = true

recursors = ["8.8.8.8", "1.1.1.1"]

service {
    name = "consul"
}

connect {
  enabled = true
}

ports {
  grpc = 8502
  http = 8500
  dns  = 53
}