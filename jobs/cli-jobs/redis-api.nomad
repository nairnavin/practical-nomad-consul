job "redis" {
  
  datacenters = ["dc1"]

  
  type = "service"
    
  group "cache" {
    
    count = 2
    network {
      mode = "bridge"
      port "redis_port" {
        to = "6379"
      }
    }
    
    restart {
      
      attempts = 10
      interval = "5m"

      delay = "25s"

      mode = "delay"
    }



    
    task "redis" {
      
      driver = "docker"

      
      config {
        image = "redis:3.2"
        #port_map {
          #redis_port = 6379
        #}
       ports = [
          "redis_port",
        ]
      }


      
      resources {
        cpu    = 200 # 500 MHz
        memory = 100 # 256MB

      }
    }
      
      service {
        name = "redis-api"
        #tags = ["urlprefix-/redis" ]
        port = "6379"
        check {
          name     = "alive"
          type     = "tcp"
          port = "redis_port"
          interval = "10s"
          timeout  = "2s"
        }
      }

     

    
  }
}