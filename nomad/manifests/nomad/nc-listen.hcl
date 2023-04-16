job "nc-listen" {
  datacenters = ["dc1"]
  type        = "service"

  group "nc-listen" {
    count = 3

    network {
      port "http" {
        static = 5678
        to     = 5678
      }
    }

    service {
      name     = "nc-listen"
      port     = "http"
      provider = "consul"
    }

    task "nc-listen" {
      driver = "exec"

      config {
        command = "/bin/bash"

        args = [
          "-c",
          "while true; do echo -e \"HTTP/1.1 200 OK\n\n $(date) ${NOMAD_PORT_http}\" | nc -l -p ${NOMAD_PORT_http} -q 1; done",
        ]
      }
    }
  }
}