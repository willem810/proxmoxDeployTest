provider "docker" {
  host = "tcp://<APP_HOST_IP>:2375" # Enable Docker TCP socket or use SSH
}

resource "docker_network" "private_network" {
  name = "dotnet_app_net"
}

resource "docker_container" "db" {
  name  = "postgres_db"
  image = "postgres:latest"
  networks_advanced { name = docker_network.private_network.name }
  env   = ["POSTGRES_PASSWORD=secret"]
}

resource "docker_container" "backend" {
  name  = "dotnet_backend"
  image = "my-registry.com/dotnet-app:latest"
  networks_advanced { name = docker_network.private_network.name }
  ports {
    internal = 5000
    external = 5000
  }
}
