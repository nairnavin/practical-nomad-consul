job "api" {
  datacenters = ["dc1"]
  type = "service"
  
  group "api" {
    count = 2
    
    network {
      mode = "bridge"
      port "metrics" {}
    }

    service {
      name = "api"
      tags = [ "addr:${NOMAD_HOST_ADDR_metrics}" ]
      port = "9966"

      connect {
        sidecar_service {
          proxy {
            expose {
              path {
                path             =  "/petclinicapi/actuator/prometheus"
                protocol         =  "http"
                local_path_port  =  9966
                listener_port    =  "metrics"
              }
            }
            upstreams {
              destination_name = "postgres"
              local_bind_port  = 6000
            }
          }
        }
      }
    }

    task "api" {
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

    scaling {
      min     = 2
      max     = 4
      enabled = true

      policy {
        evaluation_interval = "3s"
        cooldown            = "10s"

        check "active_connections" {
          source = "prometheus"
          query  = "avg(nomad_client_allocs_cpu_total_percent{task='api'})"

          strategy "target-value" {
            target = 70
          }
        }
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
