data_dir = "/opt/nomad"

bind_addr = "0.0.0.0"

#server {
#  enabled          = false
#  bootstrap_expect = 3
#  job_gc_threshold = "2m"
#}

datacenter = "dc1"

region = "dc1"

advertise {
  http = "{{ GetInterfaceIP `eth1` }}"
  rpc  = "{{ GetInterfaceIP `eth1` }}"
  serf = "{{ GetInterfaceIP `eth1` }}"
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}

client {
  enabled           = true
  network_interface = "eth1"
  servers           = ["172.16.1.101"]
  #host_network "internet_test" {
  #  #cidr = "12.13.14.15/32" 
  #  interface = "eth1"
  #}
  host_volume "rabbit-data" {
    path      = "/var/lib/rabbitmq/data"
    read_only = false
  }
}

consul {
  address = "127.0.0.1:8500"
}

telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}

