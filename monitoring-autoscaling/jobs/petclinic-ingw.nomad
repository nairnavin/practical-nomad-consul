job "ingw" {

  datacenters = ["dc1"]

  group "ingw" {

    count = 2
    network {
      mode = "bridge"
      port "web-inbound" {
        to     = 8080
      }
      port "api-inbound" {
        to     = 8090
      }
    }

    service {
      name = "apigw"
      port = "api-inbound"

      tags = [
        "urlprefix-/petclinicapi"
      ]

      connect {
        gateway {
          proxy {
          }
          ingress {
            listener {
              port     = 8090
              protocol = "tcp"
              service {
                name = "api"
              }
            }          
          }
        }
      }

      check {
        type = "http"
        port = "api-inbound"
        path = "/petclinicapi/actuator/health"
        interval = "10s"
        timeout = "2s"
      }

    }

    service {
      name = "webgw"
      port = "web-inbound"

      tags = [
        "urlprefix-/petclinic/"
      ]

      connect {
        gateway {
          proxy {
          }
          ingress {
            listener {
              port     = 8080
              protocol = "tcp"
              service {
                name = "web"
              }
            }            
          }
        }
      }

      check {
        type = "http"
        port = "web-inbound"
        path = "/petclinic/index.html"
        interval = "10s"
        timeout = "2s"
      }
    }
  }
}
