job "petclinic-ingw" {

  datacenters = ["dc1"]

  group "petclinic-ingw" {

    count = 2
    network {
      mode = "bridge"
      port "web-inbound" {
        static = 8080
        to     = 8080
      }
      port "api-inbound" {
        static = 8090
        to     = 8090
      }  
      port "redis-inbound" {
        static = 6379
        to     = 6379
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
        path = "/petclinicapi/swagger-ui.html"
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
        "urlprefix-:6379", "proto=tcp"
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
              port     = 6379
              protocol = "tcp"
              service {
                name = "redis-api"
              }
            }          
          }
        }
      }
    }


  }
}
