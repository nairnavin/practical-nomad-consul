data_dir = "/opt/consul"

server           = true
bootstrap_expect = 1 
advertise_addr   = "{{ GetInterfaceIP `eth1` }}"
client_addr      = "0.0.0.0"
#bind_addr        = "{{ GetInterfaceIP `eth1` }}"
bind_addr        = "0.0.0.0"
#dns = "{{ GetInterfaceIP `eth1` }}"
connect {
  enabled = true
}
ui_config {
  enabled = true
}
ports {
  grpc = 8502
}
#ui               = true
datacenter       = "dc1"
#retry_join       = ["172.16.1.101", "172.16.1.102", "172.16.1.103"]
encrypt = "1x0HW1jDNo+bLHlwsNGa+EguIW/0FK74HYfXC/ExNls="
encrypt_verify_incoming = true
encrypt_verify_outgoing = true

telemetry {
  prometheus_retention_time = "30s"
}