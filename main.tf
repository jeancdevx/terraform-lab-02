terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
}

provider "docker" {
}

# terraform init
# terraform plan
# terraform apply
# terraform apply -y
# terraform destroy
# terraform workspace list