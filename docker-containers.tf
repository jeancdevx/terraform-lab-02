resource "docker_container" "nginx" {
  name  = "nginx-${terraform.workspace}"
  image = "nginx:stable-alpine3.21-perl"
  
  networks_advanced {
    name = docker_network.app_net.name
  }
}

resource "docker_container" "redis" {
  name = "redis-${terraform.workspace}"
  image = "redis:alpine3.22"

  networks_advanced {
    name = docker_network.persistence_net.name
  }
}

resource "docker_container" "postgres" {
  name = "postgres-${terraform.workspace}"
  image = "postgres:13.22-alpine3.22"

  env = [
    "POSTGRES_PASSWORD=joaquinrenacuajo",
    "POSTGRES_USER=dev",
    "POSTGRES_DB=test"
  ]

  networks_advanced {
    name = docker_network.persistence_net.name
  }
}

resource "docker_container" "grafana" {
  name = "grafana-${terraform.workspace}"
  image = "grafana/grafana:nightly-ubuntu"

  env = [
    "GF_SECURITY_ADMIN_PASSWORD=pepetiene123"
  ]

  networks_advanced {
    name = docker_network.monitor_net.name
  }
}