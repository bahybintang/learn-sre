data_dir = "/opt/nomad/data"

server {
  enabled          = true
  bootstrap_expect = 2
}

client {
  enabled = true
}