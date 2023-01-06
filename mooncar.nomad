job "mooncar" {
  datacenters = ["dc1"]

  type = "service"

  group "traefik" {
    count = 1
    network {
       port "grpc" {
         to = 50051
       }
    }

    service {
      name = "mooncar"
      port = "grpc"
      provider = "consul"

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "5s"
      }

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.mooncar.rule=Host(`mooncar.nomad.localhost`)",
        "traefik.http.services.mooncar.loadbalancer.server.scheme=h2c",
        "traefik.http.middlewares.mooncar-grpc.grpcWeb.allowOrigins=*",
        "traefik.http.routers.mooncar.middlewares=mooncar-grpc"
      ]
    }

    task "server" {
      driver = "docker"
      config {
        image = "mooncar:local"
        ports = ["grpc"]
      }
    }
  }
}
