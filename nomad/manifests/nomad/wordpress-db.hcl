job "wordpress-db" {
  datacenters = ["dc1"]
  type        = "service"
  priority    = 100

  group "wordpress-db" {
    count = 1

    network {
      port "db" {
        static = 3306
        to     = 3306
      }
    }

    ephemeral_disk {
      migrate = true
      size    = 500
      sticky  = true
    }

    task "mysql" {
      driver = "docker"

      config {
        image = "mysql:5.7.41"
        ports = ["db"]
      }

      resources {
        cpu    = 512
        memory = 512
      }

      env {
        MYSQL_ROOT_PASSWORD = "mysql"
      }

      service {
        name = "wordpress-db"
        port = "db"

        check {
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}