variable "angular-artifact-url" {
  type = string
}

job "petclinic-web" {
  datacenters = ["dc1"]
  type = "service"
  group "petclinic-web" {
    count = 3
    update {
        canary       = 1
        max_parallel = 1
      }
    network {
      mode = "bridge"
      port "http" { to = 8080 }
    }
    service {
      name = "petclinic-web"
      #tags = [ "urlprefix-/web" ]
      port = "8080"

      connect {
        sidecar_service {}
      }

      check {
        type = "http"
        port = "http"
        path = "/petclinic/index.html"
        interval = "2s"
        timeout  = "2s"
      }
    }
    task "nginx" {
      driver = "docker"
      config {
        image = "nginx"
        ports = [
          "http",
        ]
        volumes = [
          "local/default.conf:/etc/nginx/conf.d/default.conf",
          "local/petclinic:/usr/share/nginx/html/petclinic"
        ]
      }
      artifact {
        #source      = "https://github.com/nairnavin/datasharing/raw/master/petclinic-web.zip"
        source = var.angular-artifact-url
        destination = "local/petclinic"
      }      
      template {
        data = <<EOH
          server {
            listen 8080;
            root   /usr/share/nginx/html;
            server_name nginx.service.consul;
            index  index.html index.htm;
            
            location /petclinic {
              try_files $uri$args $uri$args/ /petclinic/index.html;
            }
          }
        EOH
        destination = "local/default.conf"
      }
      resources {
        cpu    = 500 # 100 MHz
        memory = 256 # 128 MB
      }
    }
  }
}