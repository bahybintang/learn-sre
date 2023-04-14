job "docs" {
  datacenters = ["dc1"]

  type = "service"

  group "example" {
    count = 3

    network {
      port "http" {
        to = 5678
      }
    }

    service {
      name = "nc-listen"
      port = "http"
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