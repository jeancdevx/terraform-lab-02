resource "docker_network" "app_net" {
  name  = "app_net_${terraform.workspace}"
}

resource "docker_network" "persistence_net" {
  name  = "persistence_net_${terraform.workspace}"
}

resource "docker_network" "monitor_net" {
  name  = "monitor_net_${terraform.workspace}"
}