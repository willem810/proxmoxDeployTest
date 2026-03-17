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

resource "docker_container" "dotnet_app" {
  name  = "dotnet_backend"
  image = "mcr.microsoft.com/dotnet/aspnet:8.0"
  
  # This keeps the container open by starting a dummy process
  # Only use this until you have your actual app .dll ready to run
  command = ["tail", "-f", "/dev/null"] 
  
  ports {
    internal = 80
    external = 5000
  }
}
