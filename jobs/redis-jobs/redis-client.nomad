variable "upstream_service" {
  type = string
} 

variable "script_name" {
  type = string
} 

job "redis-client" {
  datacenters = ["dc1"]
  type = "service"
  group "redis-client" {
    count = 1
    network {
      mode = "bridge"
      port "api_port" {
        to = "8000"
      }
    }
    service {
      name = "redis-client"
      port = "8000"
      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "${var.upstream_service}"
              local_bind_port  = 6005
              local_bind_address = "127.0.0.1"
              mesh_gateway {
                mode = "local"
              }
            }
          }
        }
      }
    }

    task "redis-client" {
      driver = "docker"
      config {
        image = "arunlogo/redis-python:v4"
        args = [
          "python",
          "./${var.script_name}"
        ]
        ports = [
          "api_port",
        ]
    }
    resources {
        cpu    = 500
        memory = 300
      }
    restart {
      interval = "5m"
      attempts = 3
      delay    = "15s"
      mode     = "fail"      
    }
  }
}
}
