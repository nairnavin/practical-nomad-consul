variable "cluster_addr" {
  type = string
}

variable "cluster_port" {
  type = string
} 


job "envoy-proxy" {
  datacenters = ["dc1"]
  type = "service"

  group "proxy" {
    count = 2

    network {
          mode = "bridge"
       /* port "redis" {
            to = 6578
          } */

          port "admin" {
            to = 8002
          }
        }
    task "envoy-proxy" {
      driver = "docker"

      config {
        image = "envoyproxy/envoy:v1.18.4"
        args = [
          "envoy",
          "-c",
          "${NOMAD_TASK_DIR}/envoy.yaml"
        ]
        ports = ["redis","admin"]
      }
      template {
        data = <<EOF
admin:
  address:
    socket_address:
      address: 0.0.0.0
      port_value: 8002
static_resources:
  listeners:
  - name: redis_listener
    address:
      socket_address:
        address: 0.0.0.0
        port_value: 6578
    filter_chains:
    - filters:
      - name: envoy.filters.network.redis_proxy
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.filters.network.redis_proxy.v3.RedisProxy
          stat_prefix: egress_redis
          settings:
            op_timeout: 5s
            enable_redirection: true
          prefix_routes:
            catch_all_route:
              cluster: redis_cluster
  clusters:
  - name: redis_cluster
    connect_timeout: 3s
    cluster_type:
      name: envoy.clusters.redis
    dns_lookup_family: V4_ONLY
    load_assignment:
      cluster_name: redis_cluster
      endpoints:
      - lb_endpoints:
        - endpoint:
            address:
              socket_address:
                address: "${var.cluster_addr}"
                port_value: "${var.cluster_port}"
EOF
        destination = "local/envoy.yaml"        
        change_mode = "noop"
      }      
      
      resources {
        cpu    = 200
        memory = 200

        
      }
    }
    service {
        name = "envoy-proxy"
        port = "6578"
        connect {
        sidecar_service {}
      } 

        check {
          type = "http"
          path = "/ready"
          port = "admin"
          interval = "5s"
          timeout = "2s"
        }
      }

  }
}
