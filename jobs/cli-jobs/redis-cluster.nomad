job "redis-cluster" {
  datacenters = ["dc1"]


  group "redis-0" {

      count = 3

    network {
      mode = "host"
      port  "db"  {
            static = "7000"
            to = "7000"
          }
       port  "gossip"  {
            static = "17000"
            to = "17000"
        }
    }

    task "redis" {
      driver = "docker"


      config {
        image = "redis:6.2"
        network_mode = "host"
        command = "redis-server"
        args = [
          "${NOMAD_TASK_DIR}/redis.conf"
        ]

       #ports = ["db"]
         
      }
      template {
        data = <<EOF

port {{ env "NOMAD_PORT_db"}}
cluster-allow-reads-when-down yes
########################## CLUSTER DOCKER/NAT support  ########################

# In certain deployments, Redis Cluster nodes address discovery fails, because
# addresses are NAT-ted or because ports are forwarded (the typical case is
# Docker and other containers).
#
# In order to make Redis Cluster working in such environments, a static
# configuration where each node knows its public address is needed. The
# following two options are used for this scope, and are:
#
cluster-announce-ip {{ env "NOMAD_IP_db" }}
cluster-announce-port {{ env "NOMAD_PORT_db"}}
cluster-announce-bus-port {{ env "NOMAD_PORT_gossip"}}
cluster-enabled yes
cluster-config-file {{ env "NOMAD_TASK_DIR" }}/nodes.conf
cluster-node-timeout 5000
appendonly yes
EOF
        destination = "local/redis.conf"        
      }

      service {
        name = "redis"
        port = "db"
        check {
          port = "db"
          type = "tcp"
          interval = "5s"
          timeout = "3s"
          initial_status = "passing"          
        }
        
      }

     

      resources {
        cpu    = 100
        memory = 200

      }
    }
  }

  group "redis-1" {
    count = 3

    network {
      mode = "host"
      port  "db"  {
            static = "7001"
            to = "7001"
          }
    port  "gossip"  {
            static = "17001"
            to = "17001"
        }
    }

    task "redis" {
      driver = "docker"


      config {
        image = "redis:6.2"
        network_mode = "host"
        command = "redis-server"
        args = [
          "${NOMAD_TASK_DIR}/redis.conf"
        ]


      }
      template {
        data = <<EOF

port {{ env "NOMAD_PORT_db"}}
cluster-allow-reads-when-down yes
########################## CLUSTER DOCKER/NAT support  ########################

# In certain deployments, Redis Cluster nodes address discovery fails, because
# addresses are NAT-ted or because ports are forwarded (the typical case is
# Docker and other containers).
#
# In order to make Redis Cluster working in such environments, a static
# configuration where each node knows its public address is needed. The
# following two options are used for this scope, and are:
#
cluster-announce-ip {{ env "NOMAD_IP_db" }}
cluster-announce-port {{ env "NOMAD_PORT_db"}}
cluster-announce-bus-port {{ env "NOMAD_PORT_gossip"}}
cluster-enabled yes
cluster-config-file {{ env "NOMAD_TASK_DIR" }}/nodes.conf
cluster-node-timeout 5000
appendonly yes
EOF
        destination = "local/redis.conf"        
      }

      service {
        name = "redis"
        port = "db"
        check {
          port = "db"
          type = "tcp"
          interval = "5s"
          timeout = "3s"
          initial_status = "passing"          
        }
        
      }

     

      resources {
        cpu    = 100
        memory = 200

      }
    }
  }

}

