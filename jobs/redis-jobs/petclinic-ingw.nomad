job "petclinic-ingw" {

  datacenters = ["dc1"]

  group "petclinic-ingw" {

    count = 2
    network {
      mode = "bridge"
      port "web-inbound" {
        to     = 8080
      }
      port "api-inbound" {
        to     = 8090
      }  
      port "redis-inbound" {
        to     = 6378
      }    
    }

    service {
      name = "petclinic-apigw"
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
                name = "petclinic-api"
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
      name = "petclinic-webgw"
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
                name = "petclinic-web"
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

    service {
      name = "redis-apigw"
      port = "redis-inbound"

      tags = [
        "urlprefix-:6378", "proto=tcp"
      ]
      check {
          name     = "alive"
          type     = "tcp"
          port = "redis-inbound"
          interval = "10s"
          timeout  = "2s"
        }

      connect {
        gateway {
          proxy {
          }
          ingress {
            listener {
              port     = 6378
              protocol = "tcp"
              service {
                name = "envoy-proxy"
              }
            }          
          }
        }
      }
    }


  }
}
