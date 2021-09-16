variable "host" {
  type = list(string)
}

job "rabbit" {

  datacenters = ["dc1"]
  type = "service"

  group "cluster" {
    count = 2

    update {
      max_parallel = 1
    }

    migrate {
      max_parallel = 1
    }

    network {
      mode = "host"
      port "amqp" {
        to = 5672
        static = 5672
      }
      port "ui" {
        to = 15672
        static = 15672
      }
      port "epmd" {
        to = 4369
        static = 4369
      }
      port "clustering" {
        to = 25672
        static = 25672
      }
    }

    task "rabbit" {
      driver = "docker"

      config {
        #pondidum/rabbitmq:consul
        #"manikandan031/rabbitmq:consul24"
        image = "manikandan031/rabbitmq:consul24"
        ports = ["amqp", "ui", "epmd", "clustering"]
        extra_hosts = var.host
        hostname="${attr.unique.hostname}"
      }

      env {
        RABBITMQ_ERLANG_COOKIE = "rabbitmq"
        RABBITMQ_DEFAULT_USER = "guest"
        RABBITMQ_DEFAULT_PASS = "guest"
        CONSUL_HOST = "${attr.unique.network.ip-address}"
      }
    }
  }
}