resource "docker_container" "app_net" {
  name  = "nginx-${terraform.workspace}"
  image = "nginx:stable-alpine3.21-perl"

  ports {
    internal = 80
    external = var.nginx_external_port[terraform.workspace]
  }
  
  networks_advanced {
    name = "app_net"
  }
}

resource "docker_container" "redis" {
  name = "redis"
  image = "redis:alpine3.22"

  ports {
    internal = 6379
    external = var.redis_external_port[terraform.workspace]
  }

  networks_advanced {
    name = "persistence_net"
  }
}

resource "docker_container" "postgres" {
  name = "postgres"
  image = "postgres:alpine3.22"

  ports {
    internal = 5432
    external = var.postgres_external_port[terraform.workspace]
  }

  networks_advanced {
    name = "persistence_net"
  }
}

resource "docker_container" "grafana" {
  name = "grafana"
  image = "grafana/grafana:latest"

  ports {
    internal = 3000
    external = var.grafana_external_port[terraform.workspace]
  }

  networks_advanced {
    name = "monitor_net"
  }
}