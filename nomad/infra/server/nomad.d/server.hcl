datacenter = "dc1"
data_dir   = "/opt/nomad/data"
bind_addr  = "{{ GetInterfaceIP \"eth1\" }}"

server {
  enabled          = true
  bootstrap_expect = 1
}

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