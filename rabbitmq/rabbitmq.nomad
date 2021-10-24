job "rabbit" {

  datacenters = ["dc1"]
  type = "service"

  group "cluster" {
    count = 3

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

    volume "rabbit-data" {
      type      = "host"
      source    = "rabbit-data"
      read_only = false
    }

    task "rabbit" {
      driver = "docker"

      volume_mount {
        volume      = "rabbit-data"
        destination = "/var/lib/rabbitmq"
        read_only = false
      }

      config {
        image = "rabbitmq:management-alpine"
        ports = ["ui", "epmd", "amqp", "clustering"]
        hostname="${attr.unique.hostname}"
        extra_hosts = [
          # The below should be automated
          "client-dc1-2:172.16.1.102",
          "client-dc1-3:172.16.1.103",
          "server-dc1-1:172.16.1.101"
        ]
        volumes = [
          "local/rabbitmq.conf:/etc/rabbitmq/rabbitmq.conf"
        ]
      }

      template {
        data = <<EOH
          loopback_users.guest = false
          hipe_compile = false
          management.listener.ssl = false
          cluster_formation.peer_discovery_backend = rabbit_peer_discovery_consul
          cluster_formation.consul.host = 172.16.1.101
          cluster_formation.consul.svc_addr_auto = true
          cluster_formation.consul.svc_addr_use_nodename = false
        EOH
        destination = "local/rabbitmq.conf"
      }

      env {
        RABBITMQ_DEFAULT_USER = "guest"
        RABBITMQ_DEFAULT_PASS = "guest"
        RABBITMQ_ERLANG_COOKIE = "rabbitmq"
        RABBITMQ_MNESIA_BASE = "/var/lib/rabbitmq"
      }

//      service {
//        name = "rabbitmq"
//        port = "amqp"
//      }
    }
  }
}