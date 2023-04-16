job "wordpress" {
  datacenters = ["dc1"]
  type        = "service"

  group "wordpress" {
    count = 1

    network {
      port "http" {
        static = 8080
        to     = 80
      }
    }

    task "wordpress" {
      driver = "docker"

      config {
        image = "wordpress:php8.2-fpm"
        ports = ["http"]
      }

      resources {
        cpu    = 512
        memory = 512
      }

      env {
        WORDPRESS_DB_HOST     = "wordpress-db.service.dc1.consul"
        WORDPRESS_DB_USER     = "root"
        WORDPRESS_DB_PASSWORD = "mysql"
        WORDPRESS_DB_NAME     = "wordpress"
      }

      service {
        name     = "wordpress"
        port     = "http"
        provider = "consul"

        check {
          type     = "http"
          path     = "/wp-admin/install.php"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}