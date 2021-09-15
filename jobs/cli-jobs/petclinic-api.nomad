job "petclinic-api" {
  datacenters = ["dc1"]
  type = "service"
  group "petclinic-api" {
    count = 2
    network {
      mode = "bridge"
      port "api_port" {
        to = "9966"
      }
    }
    service {
      name = "petclinic-api"
      tags = [ "addr:${NOMAD_HOST_ADDR_api_port}" ]
      port = "9966"

      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "postgres"
              local_bind_port  = 6000
            }
          }
        }
      }

      check {
        type = "http"
        port = "api_port"
        path = "/petclinicapi/actuator/health"
        interval = "10s"
        timeout = "2s"
      }

    }

    task "petclinic-api" {
      driver = "java"
      config {
        jar_path    = "/tmp/spring-petclinic-rest-2.4.3.jar"
        jvm_options = ["-Xmx256m", "-Xms256m"]
      }
      artifact {
        source = "https://github.com/nairnavin/datasharing/raw/master/spring-petclinic-rest-2.4.3.jar"
        destination = "/tmp"
      }
      resources {
        cpu    = 500
        memory = 300
      }
      env {
        API_PORT = "9966"
      }
    }
    restart {
      interval = "5m"
      attempts = 3
      delay    = "15s"
      mode     = "fail"      
    }
  }
}
