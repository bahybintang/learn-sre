job "docs" {
  datacenters = ["dc1"]

  group "example" {
    count = 3

    network {
      port "http" {
        to = 5678
      }
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