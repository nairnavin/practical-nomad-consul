job "redis-cluster" {
  datacenters = ["dc1"]


  group "redis-0" {

        affinity {
    attribute = "${attr.unique.hostname}"
    value     = "client-dc1-2"
        }

    network {
      mode = "host"
      port  "db"  {
            static = "7000"
            to = "7000"
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
cluster-announce-bus-port 17000
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
           affinity {
    attribute = "${attr.unique.hostname}"
    value     = "client-dc1-2"
        }

    network {
      mode = "host"
      port  "db"  {
            static = "7001"
            to = "7001"
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
cluster-announce-bus-port 17001
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


 group "redis-2" {
          affinity {
    attribute = "${attr.unique.hostname}"
    value     = "client-dc1-2"
        }

    network {
      mode = "host"
      port  "db"  {
            static = "7002"
            to = "7002"
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
cluster-announce-bus-port 17002
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

  group "redis-3" {
           affinity {
    attribute = "${attr.unique.hostname}"
    value     = "client-dc1-3"
        }

    network {
      mode = "host"
      port  "db"  {
            static = "7003"
            to = "7003"
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
cluster-announce-bus-port 17003
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

  group "redis-4" {
affinity {
    attribute = "${attr.unique.hostname}"
    value     = "client-dc1-3"
        }
    network {
      mode = "host"
      port  "db"  {
            static = "7004"
            to = "7004"
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
cluster-announce-bus-port 17004
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


 group "redis-5" {
affinity {
    attribute = "${attr.unique.hostname}"
    value     = "client-dc1-3"
        }
    network {
      mode = "host"
      port  "db"  {
            static = "7005"
            to = "7005"
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
cluster-announce-bus-port 17005
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

