datacenter = "dc1"

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