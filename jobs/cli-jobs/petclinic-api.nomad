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
      #tags = [ "urlprefix-/api" ]
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
        path = "/petclinicapi/swagger-ui.html"
        interval = "10s"
        timeout = "2s"
      }

    }

    task "petclinic-api" {
      driver = "java"
      config {
        jar_path    = "/tmp/spring-petclinic-rest-2.4.2.jar"
        jvm_options = ["-Xmx256m", "-Xms256m"]
      }
      artifact {
        #source = "https://github.com/ManikandanS86/pet-clinic-artifactory/raw/master/spring-petclinic-rest-2.4.2.jar"
        source = "https://github.com/nairnavin/datasharing/raw/master/spring-petclinic-rest-2.4.2.jar"
        destination = "/tmp"
      }
      resources {
        cpu    = 500
        memory = 300
      }
      env {
        API_PORT = "9966" #"${NOMAD_PORT_api_port}"
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
