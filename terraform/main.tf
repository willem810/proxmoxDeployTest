# No backend block needed for local state
terraform {
  backend "local" {
    path = "/home/github-runner/opentofu-states/proxmoxdeploytest.tfstate"
  }
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  # Connect to your Docker LXC via SSH
  host = "ssh://root@192.168.2.28:22"
}

# Example resource
resource "docker_container" "dotnet_app" {
  name  = "dotnet_backend"
  image = "mcr.microsoft.com/dotnet/aspnet:8.0"
  ports {
    internal = 80
    external = 5000
  }
}
