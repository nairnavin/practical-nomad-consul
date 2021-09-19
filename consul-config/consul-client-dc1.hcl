data_dir = "/opt/consul"

server           = false
advertise_addr   = "{{ GetInterfaceIP `eth1` }}"
client_addr      = "0.0.0.0"
bind_addr      = "0.0.0.0"
log_level = "INFO"
enable_syslog = true
leave_on_terminate = true
ui               = false
datacenter       = "dc1"
start_join       = ["172.16.1.101"]
retry_join       = ["172.16.1.101"]
ports {
  grpc = 8502
}
connect {
  enabled = true
}
encrypt = "1x0HW1jDNo+bLHlwsNGa+EguIW/0FK74HYfXC/ExNls="
encrypt_verify_incoming = true
encrypt_verify_outgoing = true

telemetry {
  prometheus_retention_time = "30s"
}