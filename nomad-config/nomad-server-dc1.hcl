data_dir = "/opt/nomad"

bind_addr = "0.0.0.0"

server {
  enabled          = true
  bootstrap_expect = 1
  #job_gc_threshold = "2m"
}

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
}

consul {
  address = "172.16.1.101:8500"
}
