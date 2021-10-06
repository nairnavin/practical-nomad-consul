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
    }

    task "petclinic-api" {
      driver = "exec"
      config {
        command = "envconsul"
        args    = ["--config", "local/envconsul.hcl", "java", "-jar", "/tmp/spring-petclinic-rest-2.4.2.jar", "-Xms256M", "-Xmx256M", "--nogui;"]
      }
      artifact {
        source = "https://github.com/sankita15/spring-petclinic-rest/raw/master/envconsul_jar/spring-petclinic-rest-2.4.2.jar"
        destination = "/tmp"
      }
      template {
        data = <<EOH
          consul {
            address = "172.16.1.101:8500"
          }
          prefix {
            path = "config/consul_kv_demo"
          }
        EOH
        destination = "local/envconsul.hcl"
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
      min     = 1
      max     = 4
      enabled = true

      policy {
        evaluation_interval = "2s"
        cooldown            = "2s"

        check "active_connections" {
          source = "prometheus"
          query  = "nomad_client_allocs_cpu_total_percent{task='petclinic-api'}"

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