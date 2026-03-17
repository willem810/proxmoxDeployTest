# No backend block needed for local state
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  # Connect to your Docker LXC via SSH
  host = "ssh://root@<DOCKER_LXC_IP>:22"
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
