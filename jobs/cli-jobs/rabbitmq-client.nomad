job "rabbitmq-client" {
  datacenters = ["dc1"]
  type = "service"
  group "rabbitmq-client" {
    count = 1
    network {
      mode = "bridge"
      port "api_port" {
        to = "8080"
      }
    }
    service {
      name = "rabbitmq-client"
      port = "8080"
      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "rabbitmq-svc"
              local_bind_port  = 6001
            }
          }
        }
      }
    }

    task "rabbitmq-client" {
      driver = "java"
      config {
        jar_path    = "/tmp/springboot-rabbitmq-0.0.1-SNAPSHOT.jar"
        jvm_options = ["-Xmx256m", "-Xms256m"]
      }
      artifact {
        # Repo -> https://github.com/ManikandanS86/springboot-rabbitmq
        source = "https://github.com/ManikandanS86/pet-clinic-artifactory/raw/master/springboot-rabbitmq-0.0.1-SNAPSHOT.jar"
        destination = "/tmp"
      }
      resources {
        cpu    = 500
        memory = 300
      }
      env {
        API_PORT = "8080"
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
