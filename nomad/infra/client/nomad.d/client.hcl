datacenter = "dc1"
bind_addr  = "{{ GetInterfaceIP \"eth1\" }}"

# data_dir tends to be environment specific.
data_dir = "/opt/nomad/data"

advertise {
  http = "{{ GetInterfaceIP \"eth1\" }}"
  rpc  = "{{ GetInterfaceIP \"eth1\" }}"
  serf = "{{ GetInterfaceIP \"eth1\" }}"
}

client {
  enabled = true
}

consul {
  address = "{{ GetInterfaceIP \"eth1\" }}:8500"
}